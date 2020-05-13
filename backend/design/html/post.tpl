{if $post->id}
    {$meta_title = $post->name scope=global}
{else}
    {$meta_title = $btr->post_new scope=global}
{/if}

{*Название страницы*}
<div class="row">
    <div class="col-lg-12 col-md-12">
        <div class="wrap_heading">
            <div class="box_heading heading_page">
                {if !$post->id}
                    {$btr->post_add|escape}
                {else}
                    {$post->name|escape}
                {/if}
            </div>
            {if $post->id}
                <div class="box_btn_heading">
                    {if $post->type_post == 'blog'}
                        {$url = {url_generator route='blog_item' url=$post->url}}
                    {elseif $post->type_post == 'news'}
                        {$url = {url_generator route='news_item' url=$post->url}}
                    {/if}
                    <a class="btn btn_small btn-info add" target="_blank" href="../{$url}">
                    {include file='svg_icon.tpl' svgId='icon_desktop'}
                    <span>{$btr->general_open|escape}</span>
                    </a>
                </div>
            {/if}
        </div>
    </div>
</div>

{*Вывод успешных сообщений*}
{if $message_success}
    <div class="row">
        <div class="col-lg-12 col-md-12 col-sm-12">
            <div class="alert alert--center alert--icon alert--success">
                <div class="alert__content">
                    <div class="alert__title">
                    {if $message_success == 'added'}
                        {$btr->post_added|escape}
                    {elseif $message_success == 'updated'}
                        {$btr->post_updated|escape}
                    {/if}
                    </div>
                </div>
                {if $smarty.get.return}
                    <a class="alert__button" href="{$smarty.get.return}">
                        {include file='svg_icon.tpl' svgId='return'}
                        <span>{$btr->general_back|escape}</span>
                    </a>
                {/if}
            </div>
        </div>
    </div>
{/if}

{*Вывод ошибок*}
{if $message_error}
    <div class="row">
        <div class="col-lg-12 col-md-12 col-sm-12">
            <div class="alert alert--center alert--icon alert--error">
                <div class="alert__content">
                    <div class="alert__title">
                    {if $message_error == 'url_exists'}
                        {$btr->post_exists|escape}
                    {elseif $message_error=='global_url_exists'}
                        {$btr->global_url_exists|escape}
                    {elseif $message_error=='empty_name'}
                        {$btr->general_enter_title|escape}
                    {elseif $message_error == 'empty_url'}
                        {$btr->general_enter_url|escape}
                    {elseif $message_error == 'url_wrong'}
                        {$btr->general_not_underscore|escape}
                    {else}
                        {$message_error|escape}
                    {/if}
                    </div>
                </div>
            </div>
        </div>
    </div>
{/if}

{*Главная форма страницы*}
<form method="post" enctype="multipart/form-data" class="fn_fast_button">
    <input type="hidden" name="session_id" value="{$smarty.session.id}" />
    <input type="hidden" name="lang_id" value="{$lang_id}" />

    <div class="row">
        <div class="col-xs-12 ">
            <div class="boxed match_matchHeight_true">
                {*Название элемента сайта*}
                <div class="row d_flex">
                    <div class="col-lg-10 col-md-9 col-sm-12">
                        <div class="fn_step-1">
                            <div class="heading_label">
                                {$btr->general_name|escape}
                            </div>
                            <div class="form-group">
                                <input class="form-control" name="name" type="text" value="{$post->name|escape}"/>
                                <input name="id" type="hidden" value="{$post->id|escape}"/>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12 col-lg-6 col-md-10">
                                <div class="fn_step-2">
                                    <div class="input-group input-group--dabbl">
                                        <span class="input-group-addon input-group-addon--left">URL</span>
                                        <input name="url" class="fn_meta_field form-control fn_url {if $post->id}fn_disabled{/if}" {if $post->id}readonly=""{/if} type="text" value="{$post->url|escape}" />
                                        <input type="checkbox" id="block_translit" class="hidden" value="1" {if $post->id}checked=""{/if}>
                                        <span class="input-group-addon fn_disable_url">
                                            {if $post->id}
                                                <i class="fa fa-lock"></i>
                                            {else}
                                                <i class="fa fa-lock fa-unlock"></i>
                                            {/if}
                                        </span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        {get_design_block block="post_general"}
                    </div>
                    <div class="col-lg-2 col-md-3 col-sm-12">
                        <div class="activity_of_switch">
                            <div class="fn_step-3 activity_of_switch_item"> {* row block *}
                                <div class="okay_switch clearfix">
                                    <label class="switch_label">{$btr->general_enable|escape}</label>
                                    <label class="switch switch-default">
                                        <input class="switch-input" name="visible" value='1' type="checkbox" id="visible_checkbox" {if $post->visible}checked=""{/if}/>
                                        <span class="switch-label"></span>
                                        <span class="switch-handle"></span>
                                    </label>
                                </div>
                            </div>
                        </div>
                        {get_design_block block="post_switch_checkboxes"}
                    </div>
                </div>
            </div>
        </div>
    </div>
    {*Параметры элемента*}
    <div class="row">
        <div class="col-lg-4 col-md-12 pr-0">
            <div class="fn_step-4 boxed fn_toggle_wrap min_height_210px">
                <div class="heading_box">
                    {$btr->general_image|escape}
                    <div class="toggle_arrow_wrap fn_toggle_card text-primary">
                        <a class="btn-minimize" href="javascript:;" ><i class="fa fn_icon_arrow fa-angle-down"></i></a>
                    </div>
                </div>
                <div class="toggle_body_wrap on fn_card">
                    <ul class="brand_images_list">
                        <li class="brand_image_item fn_image_block">
                            {if $post->image}
                                <input type="hidden" class="fn_accept_delete" name="delete_image" value="">
                                <div class="fn_parent_image">
                                    <div class="category_image image_wrapper fn_image_wrapper text-xs-center">
                                        <a href="javascript:;" class="fn_delete_item remove_image"></a>
                                        <img src="{$post->image|resize:300:120:false:$config->resized_blog_dir}" alt="" />
                                    </div>
                                </div>
                            {else}
                                <div class="fn_parent_image"></div>
                            {/if}
                            <div class="fn_upload_image dropzone_block_image {if $post->image} hidden{/if}">
                                <i class="fa fa-plus font-5xl" aria-hidden="true"></i>
                                <input class="dropzone_image" name="image" type="file" />
                            </div>
                            <div class="category_image image_wrapper fn_image_wrapper fn_new_image text-xs-center hidden">
                                <a href="javascript:;" class="fn_delete_item remove_image"></a>
                                <img src="" alt="" />
                            </div>
                        </li>
                    </ul>
                </div>
                {get_design_block block="post_image"}
            </div>
        </div>
        {*Параметры элемента*}
        <div class="col-lg-3 col-md-12 pr-0">
            <div class="fn_step-5 boxed fn_toggle_wrap min_height_210px">
                <div class="heading_box">
                    {$btr->post_setting|escape}
                    <div class="toggle_arrow_wrap fn_toggle_card text-primary">
                        <a class="btn-minimize" href="javascript:;" ><i class="fa fn_icon_arrow fa-angle-down"></i></a>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-12 toggle_body_wrap on fn_card">
                        <div class="row">
                            <div class="col-lg-12">
                                <div class="">
                                    <div class="heading_label" >{$btr->post_type|escape}</div>
                                    <select name="type_post" class="selectpicker form-control mb-1">
                                        <option value="blog" {if $post->type_post == "blog"}selected=""{/if} >{$btr->blog_articles|escape}</option>
                                        <option value="news" {if $post->type_post == "news"}selected=""{/if} >{$btr->blog_one_news|escape}</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-lg-12">
                                <div class="">
                                    <div class="heading_label" >{$btr->general_date|escape}</div>
                                    <div class="">
                                        <input name="date" class="form-control" type="text" value="{$post->date|date}" />
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
         <div class="col-lg-5 col-md-12">
            <div class="fn_step-6 boxed fn_toggle_wrap min_height_210px">
                {backend_compact_product_list
                    title=$btr->general_recommended
                    name='related_products'
                    products=$related_products
                    label=$btr->general_recommended_add
                    placeholder=$btr->general_recommended_add
                }
                {get_design_block block="post_related_products"}
            </div>
        </div>
    </div>
    {*Параметры элемента*}
    <div class="row">
        <div class="col-lg-12 col-md-12">
            <div class="fn_step-7 boxed match fn_toggle_wrap">
                <div class="heading_box">
                    {$btr->general_metatags|escape}
                    <div class="toggle_arrow_wrap fn_toggle_card text-primary">
                        <a class="btn-minimize" href="javascript:;" ><i class="fa fn_icon_arrow fa-angle-down"></i></a>
                    </div>
                </div>
                <div class="toggle_body_wrap on fn_card row">
                    <div class="col-lg-6 col-md-6">
                        <div class="heading_label" >Meta-title <span id="fn_meta_title_counter"></span></div>
                        <input name="meta_title" class="form-control fn_meta_field mb-h" type="text" value="{$post->meta_title|escape}" />
                        <div class="heading_label" >Meta-keywords</div>
                        <input name="meta_keywords" class="form-control fn_meta_field mb-h" type="text" value="{$post->meta_keywords|escape}" />
                    </div>

                    <div class="col-lg-6 col-md-6 pl-0">
                        <div class="heading_label" >Meta-description <span id="fn_meta_description_counter"></span></div>
                        <textarea name="meta_description" class="form-control okay_textarea fn_meta_field">{$post->meta_description|escape}</textarea>
                    </div>
                </div>
                {get_design_block block="post_meta"}
            </div>
        </div>
    </div>

    {$block = {get_design_block block="post_custom_block"}}
    {if !empty($block)}
        <div class="row custom_block">
            {$block}
        </div>
    {/if}
    
    {*Описание элемента*}
    <div class="row">
        <div class="col-lg-12 col-md-12">
            <div class="fn_step-8 boxed match fn_toggle_wrap tabs">
                <div class="heading_tabs">
                    <div class="tab_navigation">
                        <a href="#tab1" class="heading_box tab_navigation_link">{$btr->general_short_description|escape}</a>
                        <a href="#tab2" class="heading_box tab_navigation_link">{$btr->general_full_description|escape}</a>
                    </div>
                    <div class="toggle_arrow_wrap fn_toggle_card text-primary">
                        <a class="btn-minimize" href="javascript:;" ><i class="icon-arrow-down"></i></a>
                    </div>
                </div>
                <div class="toggle_body_wrap on fn_card">
                    <div class="tab_container">
                        <div id="tab1" class="tab">
                            <textarea name="annotation" id="annotation" class="editor_small">{$post->annotation|escape}</textarea>
                        </div>
                        <div id="tab2" class="tab">
                            <textarea id="fn_editor" name="description" class="editor_large fn_editor_class">{$post->description|escape}</textarea>
                        </div>
                    </div>
                </div>
                <div class="row">
                   <div class="col-lg-12 col-md-12 mt-1">
                        <button type="submit" class="btn btn_small btn_blue float-md-right">
                            {include file='svg_icon.tpl' svgId='checked'}
                            <span>{$btr->general_apply|escape}</span>
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</form>

{* Learning script *}
{include file='learning_hints.tpl' hintId='hint_post'}

{* Подключаем Tiny MCE *}
{include file='tinymce_init.tpl'}
{* On document load *}
{literal}
    <script src="design/js/autocomplete/jquery.autocomplete-min.js"></script>
    <script>
        $(window).on("load", function() {
            $('input[name="date"]').datepicker();

            // Удаление товара
        $(document).on( "click", ".fn_remove_item", function() {
            $(this).closest(".fn_row").fadeOut(200, function() { $(this).remove(); });
            return false;
        });


        // Добавление связанного товара
        var new_related_product = $('#new_related_product').clone(true);
        $('#new_related_product').remove().removeAttr('id');

        $("input#related_products").devbridgeAutocomplete({
            serviceUrl:'ajax/search_products.php',
            minChars:0,
            orientation:'auto',
            noCache: false,
            onSelect:
                    function(suggestion){
                        $("input#related_products").val('').focus().blur();
                        new_item = new_related_product.clone().appendTo('.related_products');
                        new_item.removeAttr('id');
                        new_item.find('a.related_product_name').html(suggestion.data.name);
                        new_item.find('a.related_product_name').attr('href', 'index.php?controller=ProductAdmin&id='+suggestion.data.id);
                        new_item.find('input[name*="related_products"]').val(suggestion.data.id);
                        if(suggestion.data.image)
                            new_item.find('img.product_icon').attr("src", suggestion.data.image);
                        else
                            new_item.find('img.product_icon').remove();
                        new_item.show();
                    },
            formatResult:
                    function(suggestions, currentValue){
                        var reEscape = new RegExp('(\\' + ['/', '.', '*', '+', '?', '|', '(', ')', '[', ']', '{', '}', '\\'].join('|\\') + ')', 'g');
                        var pattern = '(' + currentValue.replace(reEscape, '\\$1') + ')';
                        return "<div>" + (suggestions.data.image?"<img align=absmiddle src='"+suggestions.data.image+"'> ":'') + "</div>" +  "<span>" + suggestions.value.replace(new RegExp(pattern, 'gi'), '<strong>$1<\/strong>') + "</span>";
                    }

        });
        });
    </script>
{/literal}
