<?php


namespace Okay\Modules\OkayCMS\Banners\Backend\Controllers;


use Okay\Admin\Controllers\IndexAdmin;
use Okay\Modules\OkayCMS\Banners\Entities\BannersEntity;
use Okay\Modules\OkayCMS\Banners\Helpers\BannersHelper;

class BannersAdmin extends IndexAdmin
{
    public function fetch(
        BannersEntity $bannersEntity,
        BannersHelper $bannersHelper
    ) {
        /*Принимаем выбранные группы баннеров*/
        if ($this->request->method('post')) {
            $ids = $this->request->post('check');
            if (is_array($ids)) {
                switch ($this->request->post('action')) {
                    case 'disable': {
                        /*Выключаем группы баннеров*/
                        $bannersEntity->update($ids, ['visible'=>0]);
                        break;
                    }
                    case 'enable': {
                        /*Включаем группы банннеров*/
                        $bannersEntity->update($ids, ['visible'=>1]);
                        break;
                    }
                    case 'delete': {
                        /*Удаляем группы баннеров*/
                        $bannersEntity->delete($ids);
                        break;
                    }
                }
            }
            
            // Сортировка
            $positions = $this->request->post('positions');
            $ids = array_keys($positions);
            sort($positions);
            foreach($positions as $i=>$position) {
                $bannersEntity->update($ids[$i], ['position'=>$position]);
            }
        }

        $banners = $bannersHelper->getBannersListForAdmin();

        $this->design->assign('banners', $banners);

        $this->response->setContent($this->design->fetch('banners.tpl'));
    }
    
}
