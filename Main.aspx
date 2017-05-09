<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Main.aspx.vb" Inherits="Main" %>

<%@ Register Src="~/MenuControl/MenuUserControl.ascx" TagName="UserControl" TagPrefix="uc" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <script type="text/javascript" src="js/jquery.js"></script>
    <script src="js/uikit.min.js" type="text/javascript"></script>
    <link href="css/uikit.min.css" rel="stylesheet" type="text/css" />
    <link href="css/GridStyle.css" rel="stylesheet" />
    <title>::ระบบจัดการทรัพย์หลุด::</title>
    <script type="text/javascript">
        $(document).ready(function () {
            $('#estimate').click(function () {
                $('#loadingmessageMain').show();
                $(this).addClass('uk-active');
                $('li').not($(this)).removeClass('uk-active');
                $('#content').load("MainEstimate.aspx");
                $('#loadingmessageMain').hide();
            });

            $('#listall').click(function () {
                $('#loadingmessageMain').show();
                $(this).addClass('uk-active');
                $('li').not($(this)).removeClass('uk-active');
                $('#content').load("ListAll.aspx");
                $('#loadingmessageMain').hide();
            });

            $('#manage').click(function () {
                $('#loadingmessageMain').show();
                $(this).addClass('uk-active');
                $('li').not($(this)).removeClass('uk-active');
                $('#content').load("SetAsset.aspx");
                $('#loadingmessageMain').hide();
            });

            $('#buyback').click(function () {
                $('#loadingmessageMain').show();
                $(this).addClass('uk-active');
                $('li').not($(this)).removeClass('uk-active');
                $('#content').load("BuyBack.aspx");
                $('#loadingmessageMain').hide();
            });

            $('#auction').click(function () {
                $('#loadingmessageMain').show();
                $(this).addClass('uk-active');
                $('li').not($(this)).removeClass('uk-active');
                $('#content').load("Auction.aspx");
                $('#loadingmessageMain').hide();
            });

            $('#managetray').click(function () {
                $('#loadingmessageMain').show();
                $(this).addClass('uk-active');
                $('li').not($(this)).removeClass('uk-active');
                $('#content').load("Managetray.aspx");
                $('#loadingmessageMain').hide();
            });


            $('#manageEvent').click(function () {
                $('#loadingmessageMain').show();
                $(this).addClass('uk-active');
                $('li').not($(this)).removeClass('uk-active');
                $('#content').load("ManageEvent.aspx");
                $('#loadingmessageMain').hide();
            });

            $('#TicketIn').click(function () {
                $('#loadingmessageMain').show();
                $(this).addClass('uk-active');
                $('li').not($(this)).removeClass('uk-active');
                $('#content').load("TicketIn.aspx");
                $('#loadingmessageMain').hide();
            });

            $('#report').click(function () {
                $('#loadingmessageMain').show();
                $(this).addClass('uk-active');
                $('li').not($(this)).removeClass('uk-active');
                $('#content').load("ReportMain.aspx");
                $('#loadingmessageMain').hide();
            });

            $('#estimateManager').click(function () {
                $('#loadingmessageMain').show();
                $(this).addClass('uk-active');
                $('li').not($(this)).removeClass('uk-active');
                $('#content').load("DefaultManager.aspx");
                $('#loadingmessageMain').hide();
            });

        });
    </script>
</head>
<body>
    <form id="form10" runat="server">
        <%-- header--%>
        <uc:UserControl ID="MyNav" runat="server" />
        <%-- End header--%>
        <asp:HiddenField ID="hiddenRole" runat="server" />
    </form>
    <div class="uk-grid">
        <div class="uk-width-1-5">
            <ul class="uk-tab uk-tab-left uk-width-medium-1-1">
                <li id="TicketIn"><a>เอาตั๋วเข้ากิจกรรม</a></li>
                <li id="estimateManager"><a>ประเมินราคาตั๋วโดยผู้จัดการ</a></li>
                <li id="estimate"><a>ประเมินราคาตั๋วโดยกรรมการ</a></li>
                <li id="listall"><a>รายการทรัพย์หลุดทั้งหมด</a></li>
                <li id="manage"><a>จัดชุด</a></li>
                <li id="managetray"><a>จัดถาด</a></li>
                <li id="buyback"><a>ซื้อคืน</a></li>
                <li id="auction"><a>ประมูลทรัพย์หลุด</a></li>
                <li id="manageEvent"><a>จัดการกิจกรรม</a></li>
                <li id="report"><a>รายงาน</a></li>
                <li id=""><a></a></li>
                <li id=""><a></a></li>
                <li id=""><a></a></li>
                <li id=""><a></a></li>
                <li id=""><a></a></li>
                <li id=""><a></a></li>
                <li id=""><a></a></li>
                <li id=""><a></a></li>
                <li id=""><a></a></li>
                <li id=""><a></a></li>
                <li id=""><a></a></li>
            </ul>
        </div>
        <div class="uk-width-3-5">
            <div id='loadingmessageMain' style='display: none'>
                <img src="img/ajax-loader.gif" />
            </div>

            <div id="content"></div>
        </div>
        <div class="uk-width-1-5">
        </div>
    </div>

</body>
</html>
