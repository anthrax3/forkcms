<?php

namespace App\Form\Type\Backend;

use App\Component\Model\BackendModel;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\Extension\Core\Type\HiddenType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolver;

class DeleteType extends AbstractType
{
    public function buildForm(FormBuilderInterface $builder, array $options): void
    {
        $builder->setAction(BackendModel::createUrlForAction($options['action'], $options['module']));

        $builder->add($options['id_field_name'], HiddenType::class);
    }

    public function configureOptions(OptionsResolver $resolver): void
    {
        $resolver->setRequired([
            'module',
            'action',
            'id_field_name',
        ]);

        $resolver->setDefaults([
            'action' => 'Delete',
            'id_field_name' => 'id',
        ]);
    }
}
