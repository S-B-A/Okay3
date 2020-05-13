<?php


namespace Okay\Admin\Controllers;


use Okay\Admin\Helpers\BackendSettingsHelper;
use Okay\Entities\RouterCacheEntity;

class SettingsRouterAdmin extends IndexAdmin
{

    public function fetch(
        BackendSettingsHelper $backendSettingsHelper,
        RouterCacheEntity $cacheEntity
    ) {
        if ($this->request->method('POST')) {

            // Если сменили стратегию генерации урла, очистим кеш для прежней стратегии
            if ($this->settings->get('product_routes_template') != $this->request->post('product_routes_template')) {
                $cacheEntity->deleteProductsCache();
            }
            if ($this->settings->get('category_routes_template') != $this->request->post('category_routes_template')) {
                $cacheEntity->deleteCategoriesCache();
            }
            
            $backendSettingsHelper->updateRouterSettings();
            $this->design->assign('message_success', 'saved');
        }

        $this->response->setContent($this->design->fetch('settings_router.tpl'));
    }
}