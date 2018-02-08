<?php

namespace Backend\Modules\MediaGalleries\Actions;

use Backend\Core\Engine\Base\ActionIndex as BackendBaseActionIndex;
use App\Component\Locale\BackendLanguage;
use App\Component\Model\BackendModel;
use Backend\Modules\MediaGalleries\Domain\MediaGallery\MediaGalleryDataGrid;
use Backend\Modules\MediaLibrary\Domain\MediaGroup\TypeType;

/**
 * This is the class to Show all MediaGallery Entities
 */
class MediaGalleryIndex extends BackendBaseActionIndex
{
    public function execute(): void
    {
        parent::execute();

        $form = $this->createForm(
            TypeType::class,
            null,
            [
                'action' => BackendModel::createUrlForAction('MediaGalleryAdd'),
                'method' => 'GET',
            ]
        );

        $this->template->assign('warnings', self::getWarnings());
        $this->template->assign('dataGrid', MediaGalleryDataGrid::getHtml());
        $this->template->assign('form', $form->createView());

        $this->parse();
        $this->display();
    }

    public static function getWarnings(): array
    {
        // MediaLibrary "Index" action should be allowed
        if (BackendModel::isModuleInstalled('MediaLibrary')) {
            return [];
        }

        // Add warning
        return [
            [
                'message' => sprintf(
                    BackendLanguage::err('MediaLibraryModuleRequired', 'MediaGalleries'),
                    BackendModel::createUrlForAction('Modules', 'Extensions')
                ),
            ],
        ];
    }
}
