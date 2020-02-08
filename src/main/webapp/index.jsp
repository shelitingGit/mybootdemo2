<%--
  Created by IntelliJ IDEA.
  User: sheli
  Date: 2020/2/7
  Time: 12:50
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" import="com.po.*,com.service.*,com.serviceImpl.*,com.controller.*,java.util.*"%>
<html>
<head>

    <title>Title</title>
    <script type="text/javascript" src="js/jquery-1.9.1.js"></script>
    <script>
        /***********初始化下拉列表框*************/
        $(function(){
            // $("#form2").attr('style','display:none');
            //显示列表的方法
            // alert("hello");
            $("#btsave").show();
            $("#btupdate").hide();
            showAll();
        });

        /*****************************************/
        /*************显示列表************************/
        var page=1;
        var rows=5;
        var maxpage=1;
        function showAll(){
            //使用Ajax获取后台op=5数据
            // alert("page="+page+",rows="+rows);

            $.getJSON("findAll.do?page="+page+"&rows="+rows,function(pb){
                // alert("77");
                page=pb.page;
                // alert(pb.page);
                rows=pb.rows;
                // alert(pb.rows);
                maxpage=pb.maxpage;
                // alert(pb.maxpage);
                /* alert("page"+page+"rows"+rows+"maxpage"+maxpage);
                alert(JsonPageBean.pagelist.length); */
                var tablehead="<table height='400' align='center' border='0'>"
                    +"<tr align='center' bgcolor=' #FFE4B5'  height='35' >"
                    +"<td width='80'>编号</td>"
                    +"<td width='130'>城市</td>"
                    +"<td width='200'>店铺名</td>"
                    +"<td width='150'>招牌菜</td>"
                    +"<td width='260'>地址</td>"
                    +"<td width='100'>点赞数</td>"
                    +"<td width='200'></td>"
                    +"</tr>"
                var trs="";
                for(var i=0;i<pb.pagelist.length;i++){
                    var food=pb.pagelist[i];
                    trs+="<tr>"
                        +"<td width='80'>"+food.f_id+"</td>"
                        +"<td width='130'>"+food.f_city+"</td>"
                        +"<td width='200'>"+food.f_shopname+"</td>"
                        +"<td width='150'>"+food.f_special+"</td>"
                        +"<td width='260'>"+food.f_address+"</td>"
                        +"<td width='90'>"+food.f_like+"</td>"
                        +"<td><input type='button' id='btdelete' name='btdelete' value='删除'   onclick='deleteById("+food.f_id+")'><input type='button' id='btedit' name='btedit' value='编辑' onclick='dofindById("+food.f_id+")'></td>"
                        +"</tr>"
                }

                var tableend=tablehead+trs+"</table>";
                //将值设置到div
                $("#mytable").html(tableend);
                //给分页组件赋值
                $("#rows").val(rows);
                $("#page").val(page);
                $("#pagetable").html(page+"/"+maxpage);

                //处理分页的按钮--显示和隐藏
                if(page==1&&maxpage==1){//总一页(全隐藏)
                    $("#btup").attr('disabled',true);
                    $("#btfirst").attr('disabled',true);
                    $("#btnext").attr('disabled',true);
                    $("#btlast").attr('disabled',true);
                }
                if(page==1){//第一页（隐藏前两个）
                    $("#btup").attr('disabled',true);
                    $("#btfirst").attr('disabled',true);
                }
                if(page==1&&maxpage>1){//第一页（释放后两个）
                    $("#btnext").attr('disabled',false);
                    $("#btlast").attr('disabled',false);
                }
                if(page>1&&page<maxpage){//中间页（全释放）
                    $("#btup").attr('disabled',false);
                    $("#btfirst").attr('disabled',false);
                    $("#btnext").attr('disabled',false);
                    $("#btlast").attr('disabled',false);
                }
                if(page==maxpage&&page>1){//最后一页（隐藏后两个，释放前两个）
                    $("#btnext").attr('disabled',true);
                    $("#btlast").attr('disabled',true);
                    $("#btup").attr('disabled',false);
                    $("#btfirst").attr('disabled',false);
                }
            });
        }
        /*************显示列表end*********************/
        /*************分页组件*********************/
        $(function(){
            $("#btfirst").click(function(){
                page=1;
                showAll();
            });
            $("#btup").click(function(){
                page=page-1;
                if(page<1){
                    page=1;
                }
                showAll();
            });
            $("#btnext").click(function(){
                page=page+1;
                if(page>maxpage){
                    page=maxpage;
                }
                showAll();
            });
            $("#btlast").click(function(){
                page=maxpage;
                showAll();
            });
            //更改每页记录数
            $("#btchaneRows").click(function(){
                var rowsval=$("#rows").val();
                if(isNaN(rowsval)){
                    alert("请输入正确数字");
                    $("#rows").val(rows);
                    return;
                }
                rows=rowsval;
                showAll();
            });
            //更改页数
            $("#btchanePage").click(function(){
                var pageval=$("#page").val();
                if(isNaN(pageval)){
                    alert("请输入正确数字");
                    $("#page").val(page);
                    return;
                }
                page=pageval;
                showAll();
            });
        });
        /*************分页组件end******************/
        /**********************保存方法*******************************/
        $(function(){
            $("#btsave").click(function(){
                //获取表单元素的值
                var f_city=$("#f_city").val();
                var f_shopname=$("#f_shopname").val();//获取选中的单选按钮值
                var f_special=$("#f_special").val();
                var f_address=$("#f_address").val();
                //组装为json对象准备传递给服务器save_Student路径对应得方法
                var food={'f_city':f_city,'f_shopname':f_shopname,'f_special':f_special,'f_address':f_address};
                //发送json对象到服务器
                $.post('add_Food.do',food,function(code){
                    alert("fh"+code)
                    if(code=='1'){
                        alert('保存成功！');
                        showAll();//刷新表格
                    }else{
                        alert('保存失败！');
                    }
                });
            });
        });
        /*************************************************************/

        /**********************更新方法*******************************/
        $(function(){
            $("#btupdate").click(function(){
                //获取表单元素的值
                alert("更新");

                var f_id=$("#f_id").val();
                var f_city=$("#f_city").val();
                var f_shopname=$("#f_shopname").val();
                var f_special=$("#f_special").val();
                var f_address=$("#f_address").val();
                var f_like=$("#f_like").val();
                //组装为json对象准备传递给服务器save_Student路径对应得方法
                var food={'f_city':f_city,'f_shopname':f_shopname,'f_special':f_special,'f_address':f_address,'f_id':f_id,'f_like':f_like};
                //发送json对象到服务器
                $.post('update_Food.do',food,function(code){
                    if(code=='1'){
                        alert('更新成功！');
                        showAll();//刷新表格
                    }else{
                        alert('更新失败！');
                    }
                });

                $("#btsave").show();
                $("#btupdate").hide();
            });
        });
        /*************************************************************/

        /********************删除事件************************************/
        function deleteById(f_id){
            var flag=window.confirm('是否真的删除！');
            if(flag){
                $.get('delById_Food.do?f_id='+f_id,function(code){
                    if(code=='1'){
                        alert('删除成功！');
                        showAll();//刷新表格
                    }else{
                        alert('删除失败！');
                    }
                });
            }
        }
        /*************************************************************/
        /***********************查找的方法*****************************/
        function dofindById(f_id){
            $.getJSON('findById_Food.do?f_id='+f_id,function(oldfood){
                //给表单元素赋值


                $("#f_id").val(oldfood.f_id);
                $("#f_city").val(oldfood.f_city);
                $("#f_shopname").val(oldfood.f_shopname);
                $("#f_special").val(oldfood.f_special);
                $("#f_address").val(oldfood.f_address);
                $("#f_like").val(oldfood.f_like);
            });

            $("#btsave").hide();
            $("#btupdate").show();
        }
        /************************************************************/


    </script>







</head>

<body>
<p align="center">美食信息&nbsp;</p>
<hr/>
<div id="mytable"></div>

<!-- 分页 -->
<form action="" id="form1" name="form1">
    <table border="0" width="900" height="100" align="center">
        <tr align="center">
            <td>
                <input type="button" name="btfirst" id="btfirst" value="首页">
            </td>
            <td>
                <input type="button" name="btup" id="btup" value="上一页">
            </td>
            <td>
                <input type="button" name="btnext" id="btnext" value="下一页">
            </td>
            <td>
                <input type="button" name="btlast" id="btlast" value="尾页">
            </td>
            <td>跳转
                <input type="text" name="page" size="2" id="page">
                页
                <input type="button" name="btchanePage" id="btchanePage" value="确定">
            </td>
            <td>每页
                <input type="text" name="rows" size="2"  id="rows">
                记录
                <input type="button" name="btchaneRows" id="btchaneRows" value="确定">
            </td>
            <td>
                <div id="pagetable"></div>
            </td>
        </tr>
    </table>
</form>
<hr/>
<form form id="form2" name="form2" method="post" action="">
    <table border="0" width="600" height="400" align="center">
        <tr align="center" bgcolor=" #96FED1">
            <td colspan="2">美食信息管理</td>
        </tr>
        <tr>
            <td>城市</td>
            <td>
                <input type="text" name="f_city" id="f_city">
            </td>
        </tr>
        <tr>
            <td>店铺名</td>
            <td>
                <input type="text" name="f_shopname" id="f_shopname">
            </td>
        </tr>
        <tr>
            <td>招牌菜</td>
            <td>
                <input type="text" name="f_special" id="f_special">
            </td>
        </tr>
        <tr>
            <td>地址</td>
            <td>
                <input type="text" name="f_address" id="f_address">
            </td>
        </tr>
        <tr align="center" bgcolor=" #96FED1">
            <td colspan="2">
                <!--  <input type="hidden" id="op" name="op" value="1" > -->
                <input type="button" name="btsave" id="btsave" value="保存" />
                <input type="button" name="btupdate" id="btupdate" value="更新" />
                <input type="reset" name="btreset" id="btreset" value="重置" />
                <input type="hidden" id="f_like" name="f_like" >
                <input type="hidden" id="f_id" name="f_id"  >
            </td>
        </tr>
    </table>
</form>
</body>
</html>