<?php

namespace Backend\Modules\ContentBlocks\Domain\ContentBlock\Command;

use App\Component\Model\BackendModel;
use App\Component\Locale\BackendLocale;
use Backend\Modules\ContentBlocks\Domain\ContentBlock\ContentBlock;
use Backend\Modules\ContentBlocks\Domain\ContentBlock\ContentBlockRepository;
use Backend\Modules\ContentBlocks\Domain\ContentBlock\Status;
use App\Domain\ModuleExtra\Type;

final class CopyContentBlocksToOtherLocaleHandler
{
    /** @var ContentBlockRepository */
    private $contentBlockRepository;

    public function __construct(ContentBlockRepository $contentBlockRepository)
    {
        $this->contentBlockRepository = $contentBlockRepository;
    }

    public function handle(CopyContentBlocksToOtherLocale $copyContentBlocksToOtherLocale): void
    {
        $contentBlocksToCopy = $this->getContentBlocksToCopy($copyContentBlocksToOtherLocale->fromLocale);
        $id = $this->contentBlockRepository->getNextIdForLanguage($copyContentBlocksToOtherLocale->toLocale);

        array_map(
            function (ContentBlock $contentBlock) use ($copyContentBlocksToOtherLocale, &$id) {
                $copyContentBlocksToOtherLocale->extraIdMap[$contentBlock->getExtraId()] = $this->getNewExtraId();
                $dataTransferObject = $contentBlock->getDataTransferObject();

                // Overwrite some variables
                $dataTransferObject->forOtherLocale(
                    $id++,
                    $copyContentBlocksToOtherLocale->extraIdMap[$contentBlock->getExtraId()],
                    $copyContentBlocksToOtherLocale->toLocale
                );

                $this->contentBlockRepository->add(ContentBlock::fromDataTransferObject($dataTransferObject));
            },
            $contentBlocksToCopy
        );
    }

    private function getContentBlocksToCopy(BackendLocale $locale): array
    {
        return (array) $this->contentBlockRepository->findBy(
            [
                'locale' => $locale,
                'status' => Status::active()
            ]
        );
    }

    private function getNewExtraId(): int
    {
        return BackendModel::insertExtra(
            Type::widget(),
            'ContentBlocks',
            'Detail'
        );
    }
}
