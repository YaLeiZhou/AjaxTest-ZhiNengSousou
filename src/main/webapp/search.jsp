<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Search-AjaxTest</title>
    <style type="text/css">
        #mydiv{
            position: absolute;
            left: 50%;
            top: 50%;
            margin-left: -200px;
            margin-top: -50px;
        }

        .mouseOver {
            background: #708090;
            color: #FFFAFA;
        }

        .mouseOut {
            background: #FFFAFA;
            color: #000000;
        }
        </style>

</head>
<body>
<%--    解决问题：--%>
<%--    1.输入框有输入时，鼠标移开输入框时(焦点消失)，显示列表消失；鼠标重新放上，有列表显示--%>
<%--    2.清空输入框，显示列表消失--%>
<%--    3.列表显示之前，清空之前的显示--%>
<%--    4.鼠标放上列表某一项时候，有颜色变化，离开时，颜色变化消失--%>

    <br/>
        <div id="mydiv">
            <input type="text" size="50" id="keyword" onkeyup="getMoreContent()"
            onblur="keywordBlur()" onfocus="getMoreContent()">
            <input type="button" width="50px" value="百度一下">

            <%--下面是内容展示区域--%>
            <div id="popDiv">
                <table id="content_table" bgcolor="#FFFAFA" border="0" cellpadding="0" cellspacing="0">
                    <tbody id="content_table_body">

                    <%--动态查询出来的数据显示在这里--%>
                    <%-- <tr><td>hello</td></tr>--%>
                    <%-- <tr><td>ajax</td></tr>--%>


                    </tbody>
                </table>
            </div>
        </div>
</body>
<script type="text/javascript">
    var xhr;
    //获得用户输入关联信息的函数
    function getMoreContent(){
        //获得用户输入
        var content=document.getElementById("keyword");

        if (content.value==""){
            clearContent();
            return;
        }
        //alert 打印输入框的内容，输入会有弹窗
        //alert(content.value);

        //给服务器传递输入的内容 ajax异步发送
        //1.创建XmlHttp对象
        xhr=creatXmlHttpRequest();
        //2.给服务器发送数据
        //escape() 函数可对字符串进行编码，这样就可以在所有的计算机上读取该字符串。
        var url="search?keyword="+escape(content.value);
        xhr.open("GET",url,true);// true表示js调用send方法后继续执行，不会等待来自服务器的相应
        //3.绑定回调函数，回调方法会在xmlHttp状态改变的时候被调用
        //xmlHttp状态（0-4），我们只关心4（完成）状态

        xhr.onreadystatechange=callback;
        xhr.send(null);
    }

    //获得XmlHttp对象
    function creatXmlHttpRequest(){
        if (window.XMLHttpRequest){
            xhr=new XMLHttpRequest();
        }else {//考虑浏览器的兼容性
            if(window.ActiveXObject){
                xhr=new ActiveXObject("Microsoft.XMLHTTP");
            }
            if(!xhr){
                xhr=new ActiveXObject("Msxml2.XMLHTTP");
            }
        }
        return xhr;
    }
    //回调函数
    //当 readyState 变为 4 时，表示请求已完成，而 status 为 200 表示成功接收到服务器响应。这时，我们可以执行相应的逻辑
    function callback(){

        //4代表完成
        if(xhr.readyState==4){
            //200代表服务器相应成功
            if(xhr.status==200){
                //交互成功，获得响应的数据是文本格式
                var result=xhr.responseText;
                //解析数据   eval方法是将json字符串转换成json对象
                /**
                 * eval(s)
                 * 如果参数s是字符串，并且字符串中的表达式是JSON格式（此时的JOSN格式外面要加上一对小括号将JSON包围起来），则eval()方法返回该JSON。
                 */
                var json=eval("("+result+")");
                //把数据展示到输入框下面
                //alert(json);  打印从后端接收过来的json测试
                //获得数据之后，动态展示数据到输入框
                setContent(json);

            }
        }
    }

    //设置关联数据展示
    function setContent(contents){

        clearContent();
        setLocation();


        //获得关联数据的长度，确定有多少个<tr></tr>
        var size=contents.length;
        //设置内容
        for (let i = 0; i < size; i++) {
            var nextNode=contents[i];//代表json格式数据的第i个元素
            var tr=document.createElement("tr");
            var td=document.createElement("td");
            td.setAttribute("border","0");
            td.setAttribute("bgcolor","#FFFAFA");
            td.onmouseover=function () {
                this.className="mouseOver";
            };
            td.onmouseout=function () {
                this.className="mouseOut";
            };
            td.onclick=function () {
                //当鼠标点击关联数据时，关联数据自动设置为输入框的内容
            };
            var text=document.createTextNode(nextNode);
            td.appendChild(text);
            tr.appendChild(td);
            document.getElementById("content_table_body").appendChild(tr);
        }
    }

    //清空之前的数据
    function clearContent(){
        var contentTableBody=document.getElementById("content_table_body");
        var size=contentTableBody.childNodes.length;
        for (let i = size-1; i >=0; i--) {
            contentTableBody.removeChild(contentTableBody.childNodes[i]);
        }
    }

    //当输入框失去焦点的时候，关联信息清空
    function keywordBlur(){
        clearContent();
    }

    //设置显示关联信息
    function setLocation(){
        //关联信息的显示位置
        var content=document.getElementById("keyword");
        var width = content.offsetWidth;//输入框的宽度
        var left = content["offsetLeft"];//距离左边框的距离
        var top = content["offsetTop"] + content.offsetHeight;//距离顶部
        //获取显示数据div
        var popdiv = document.getElementById("popdiv");
        //popdiv.style.border = "black 1px solid";
        //popdiv.style.left = left + "px";
        //popdiv.style.top = top + "px";
        //popdiv.style.width = width + "px";
        document.getElementById("content_table").style.width = width + "px";

    }
</script>
</html>