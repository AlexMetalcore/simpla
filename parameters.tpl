{capture name=tabs}
        {if in_array('products', $manager->permissions)}<li><a href="index.php?module=ProductsAdmin">Товары</a></li>{/if}
        {if in_array('categories', $manager->permissions)}<li><a href="index.php?module=CategoriesAdmin">Категории</a></li>{/if}
        {if in_array('brands', $manager->permissions)}<li><a href="index.php?module=BrandsAdmin">Бренды</a></li>{/if}
        {if in_array('features', $manager->permissions)}<li><a href="index.php?module=FeaturesAdmin">Свойства</a></li>{/if}
	<li class="active"><a href="index.php?module=ParametersAdmin">Параметры товара</a></li>
{/capture}

{$meta_title ='Параметры товара' scope=parent}

{* Подключаем Tiny MCE *}
{include file='tinymce_init.tpl'}

{* On document load *}

{* Заголовок *}
{literal}
<script src="design/js/jquery/jquery.js"></script>                                                          <script src="design/js/jquery/jquery-ui.min.js"></script>
<script>
$(function (){                                                                                                            $("a.delete").click(function() {                                                                         $('input[type="hidden"][name="action"]').val('delete');                                                    $('input[type="hidden"][name="action_id"]').val($(this).closest("div").find('input[type="hidden"][name*="parameters[parameters_id]"]').val());
	$(this).closest("form").submit();                                                                                });                                                                                                         $("form").submit(function() {                                                                              if($('input[type="hidden"][name="action"]').val()=='delete' && !confirm('Подтвердите удаление'))             return false;                   
	});                                                                                                         $("#add_variant").click(function (){                                                                        $("#form_parameters").append('<div class="hidden"><input name="parameters[parameters_id][]" type="hidden" value=""><input class="add_parametr" type="text" name="parameters[stock_parameters][]" value=""></div>');          	
$(".add_parametr").focus();
$(".button_save").click(function (event){
var parameter = $(".add_parametr").val();
if(parameter.length == 0){
	event.preventDefault();
	alert("Заполните поле!");
}
});                                                                                  
});
});
</script>
{/literal}
<div id="header">
        <h1>Параметры товара</h1>
        <a class="add" id="add_variant" href="#">Добавить параметр</a>
</div>
{if $message_success}
<div class="message message_success">
        <span class="text">{if $message_success=='added'}Параметр добавлен{elseif $message_success=='updated'}Параметры обновлены{else}{$message_success}{/if}</span>
</div>
{/if}

{if $message_error}
<!-- Системное сообщение -->
<div class="message message_error">
        <span class="text">{if $message_error=='param_exists'}Параметр существует{else}{$message_error}{/if}</span>
        <a class="button" href="{$smarty.get.return}">Вернуться</a>
</div>
<!-- Системное сообщение (The End)-->
{/if}

<form method=post id="form_parameters" enctype="multipart/form-data">
<input type=hidden name="session_id" value="{$smarty.session.id}">
			{foreach $parameters as $parameter}
			<div class="parameters">
<input name="parameters[parameters_id][{$parameter->parameters_id}]" type="hidden" value="{$parameter->parameters_id|escape}">
<input type="text" value="{$parameter->stock_parameters}" class="stock_parametr" name="parameters[stock_parameters][{$parameter->parameters_id}]"><span class="icons"><a class="delete" href="#" title="Удалить"></a><span></div>
			{/foreach}
<input type=hidden name=action value=''>
<input type=hidden name=action_id value=''> 
<input id="apply_action" class="button_green button_save" type="submit" value="Сохранить" />
</form>
<script>
/*	$("a.delete").click(function() {
     $('input[type="hidden"][name="action"]').val('delete');
    $('input[type="hidden"][name="action_id"]').val($(this).closest("parameters").find('input[type="hidden"][name*="parameters[parameters_id]"]').val());                                       $(this).closest("form").submit();
	});
	$("form").submit(function() {
                if($('input[type="hidden"][name="action"]').
val()=='delete' && !confirm('Подтвердите удаление'))                                return false;
	});
 
	$("#add_variant").click(function (){
        $("#product").append('<div class="hidden"><input name="parameters[parameters_id][]" type="hidden" value=""><input class="add_parametr" type="text" name="parameters[stock_parameters][]" value=""></div>').focus();
        $(".img_refresh").click(function () {
                var parametr = $(".add_parametr");
                var parametr_val = $(".add_parametr").val();
                //$(".stock_parametr").append($('<option></option>').attr("value", parametr_val).html(parametr_val));
                $(".stock_parametr").attr("value" , parametr_val);
                parametr.val('');
        });
        
});*/
</script>
