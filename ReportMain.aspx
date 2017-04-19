<%@ Page Language="VB" AutoEventWireup="false" CodeFile="ReportMain.aspx.vb" Inherits="ReportMain" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <script type="text/javascript" src="js/jquery.js"></script>
    <script src="js/uikit.min.js" type="text/javascript"></script>
    <link href="css/uikit.min.css" rel="stylesheet" type="text/css" />
    <link href="css/GridStyle.css" rel="stylesheet" />
    <title>::ระบบจัดการทรัพย์หลุด::</title>
    <script type ="text/javascript">
        $(document).ready(function () {
            $('#byticketid').click(function () {
                $(this).addClass('uk-active');
                $('li').not($(this)).removeClass('uk-active');
                $('#content2').load("Report/Report_5621.aspx");
            });

            $('#byticketidNo').click(function () {
                $(this).addClass('uk-active');
                $('li').not($(this)).removeClass('uk-active');
                $('#content2').load("Report/Report_5622.aspx");
            });

            $('#byticketCategory').click(function () {
                $(this).addClass('uk-active');
                $('li').not($(this)).removeClass('uk-active');
                $('#content2').load("Report/Report_5623.aspx");
            });

            $('#byticketCategory2').click(function () {
                $(this).addClass('uk-active');
                $('li').not($(this)).removeClass('uk-active');
                $('#content2').load("Report/Report_5624.aspx");
            });
        });
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <ul class="uk-tab">
            <li id="byticketid"><a>ประเมินราคาทรัพย์หลุดรายตั๋ว</a></li>
            <li id="byticketidNo"><a>ประเมินราคาทรัพย์หลุดรายตั๋วไม่มีงวด</a></li>
            <li id="byticketCategory"><a>บัญชีประเมินทรัพย์หลุดเรียงประเภททรัพย์</a></li>
            <li id="byticketCategory2"><a>บัญชีจำหน่ายทรัพย์หลุดเรียงตามประเภททรัพย์</a></li>
        </ul>
        <div id="content2"></div>
    </form>
</body>
</html>
