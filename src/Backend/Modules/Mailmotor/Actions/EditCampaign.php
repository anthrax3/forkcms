<?php

namespace Backend\Modules\Mailmotor\Actions;

/*
 * This file is part of Fork CMS.
 *
 * For the full copyright and license information, please view the license
 * file that was distributed with this source code.
 */

use Backend\Core\Engine\Base\ActionEdit as BackendBaseActionEdit;
use Backend\Core\Engine\Form as BackendForm;
use Backend\Core\Engine\Language as BL;
use Backend\Core\Engine\Model as BackendModel;
use Backend\Modules\Mailmotor\Engine\Model as BackendMailmotorModel;

/**
 * This is the edit-action, it will display a form to edit a campaign
 */
class EditCampaign extends BackendBaseActionEdit
{
    /**
     * Execute the action
     */
    public function execute()
    {
        // get parameters
        $this->id = $this->getParameter('id', 'int');

        // does the item exist
        if (BackendMailmotorModel::existsCampaign($this->id)) {
            parent::execute();
            $this->getData();
            $this->loadForm();
            $this->validateForm();
            $this->parse();
            $this->display();
        } else {
            $this->redirect(BackendModel::createURLForAction('Index') . '&error=non-existing');
        }
    }

    /**
     * Get the data
     */
    private function getData()
    {
        // get the record
        $this->record = (array) BackendMailmotorModel::getCampaign($this->id);

        // no item found, throw an exceptions, because somebody is fucking with our URL
        if (empty($this->record)) {
            $this->redirect(
                BackendModel::createURLForAction('Campaigns') . '&error=non-existing'
            );
        }
    }

    /**
     * Load the form
     */
    private function loadForm()
    {
        // create form
        $this->frm = new BackendForm('edit');

        // create elements
        $this->frm->addText('name', $this->record['name']);
    }

    /**
     * Parse the form
     */
    protected function parse()
    {
        parent::parse();

        // assign the active record and additional variables
        $this->tpl->assign('campaign', $this->record);
    }

    /**
     * Validate the form
     */
    private function validateForm()
    {
        // is the form submitted?
        if ($this->frm->isSubmitted()) {
            // cleanup the submitted fields, ignore fields that were added by hackers
            $this->frm->cleanupFields();

            // shorten fields
            $txtName = $this->frm->getField('name');

            // validate fields
            if ($txtName->isFilled(BL::err('NameIsRequired'))) {
                if ($txtName->getValue() != $this->record['name'] &&
                    BackendMailmotorModel::existsCampaignByName($txtName->getValue())
                ) {
                    $txtName->addError(BL::err('CampaignExists'));
                }
            }

            // no errors?
            if ($this->frm->isCorrect()) {
                // build item
                $item['id'] = $this->id;
                $item['name'] = $txtName->getValue();
                $item['created_on'] = BackendModel::getUTCDate('Y-m-d H:i:s');

                // update the item
                BackendMailmotorModel::updateCampaign($item);

                // trigger event
                BackendModel::triggerEvent($this->getModule(), 'after_edit_campaign', array('item' => $item));

                // everything is saved, so redirect to the overview
                $this->redirect(
                    BackendModel::createURLForAction('Campaigns') . '&report=edited&var=' . rawurlencode(
                        $item['name']
                    ) . '&highlight=id-' . $item['id']
                );
            }
        }
    }
}
