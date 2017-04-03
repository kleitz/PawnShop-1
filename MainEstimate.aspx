<%@ Page Language="VB" AutoEventWireup="false" CodeFile="MainEstimate.aspx.vb" Inherits="MainEstimate" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
   <link href="Bootstrap/Content/bootstrap.css" rel="stylesheet" />
    <link href="css/uikit.min.css" rel="stylesheet" />
    <link href="Bootstrap/Content/font-awesome.min.css" rel="stylesheet" />
    <script src="Bootstrap/Scripts/jquery-3.1.1.js" type="text/javascript"></script>
    <script src="Bootstrap/Scripts/jquery.validate.min.js" type="text/javascript"></script>
    <script src="Bootstrap/Scripts/bootstrap.min.js" type="text/javascript"></script>
    <script src="Bootstrap/Scripts/moment.js"></script>
    <script src="Bootstrap/Scripts/datepicker-thai/bootstrap-datepicker.js"></script>
    <script src="Bootstrap/Scripts/datepicker-thai/bootstrap-datepicker-thai.js"></script>
    <script src="Bootstrap/Scripts/datepicker-thai/locales/bootstrap-datepicker.th.js"></script>
    <link href="Bootstrap/css/pagination_ys.css" rel="stylesheet" />
    <link href="Bootstrap/css/datapicker/datepicker3.css" rel="stylesheet" />
    <link href="Bootstrap/css/Grid.css" rel="stylesheet" />
    <title>::ระบบจัดการทรัพย์หลุด::</title>
    <style type="text/css">
        .error {
            color: red;
        }
    </style>
    <script type="text/javascript">
        $(document).ready(function () {
            $('#estimate1').click(function () {

                var role_id = $('#hiddenRole').val();

                if (role_id == 2) {
                    $('#panelEstimate').hide();
                    $('#content').load("DefaultManager.aspx");
                    return false;
                } else {
                    $('#lblAlert').text("ท่านไม่มีสิทธิในการประเมินราคาครั้งที่ 1 ");
                    AlertModal("modalAlertSuccess");
                    return false;
                }


                //$('#content').load("DefaultManager.aspx");
                //return false;

            });
            $('#estimate2').click(function () {

                var role_estimate2 = $('#hiddenRoleEstimate2').val();

                if (role_estimate2 == 1) {
                    $('#panelEstimate').hide();
                    $('#content').load("EstimateSecond.aspx");
                    return false;
                } else {
                    $('#lblAlert').text("ท่านไม่มีสิทธิในการประเมินราคาครั้งที่ 2 ");
                    AlertModal("modalAlertSuccess");
                    return false;
                }

                //$('#content').load("EstimateSecond.aspx");
                //return false; 
            });
        });

        function AlertModal(ModalName) {
            var modalName = "#" + ModalName;
            var modal = UIkit.modal(modalName);

            if (modal.isActive()) {
                modal.hide();
            } else {
                modal.show();
            }
        }

    </script>
</head>
<body>
    <form id="form1" runat="server">
    <asp:HiddenField ID="hiddenRole" runat="server" />
    <asp:HiddenField ID="hiddenRoleEstimate2" runat="server" />
    <div class ="uk-form">
        <div id="panelEstimate">
            <table class="uk-table">
                <tr>
                    <td>
                        <button id="estimate1" class="uk-button uk-button-success" style="color: #ffffff">ประเมินครั้งที่ 1</button> &nbsp;&nbsp; โดยผู้จัดการสาขา
                    </td>
                </tr>
                <tr>
                    <td>
                        <button id="estimate2"  class="uk-button uk-button-success" style="color: #ffffff">ประเมินครั้งที่ 2</button> &nbsp;&nbsp; โดยกรรมการ
                    </td>
                </tr>
            </table>
        </div>
        <div id="content"></div>

    </div>

    <div class="uk-modal" id="modalAlertSuccess">
        <div class="uk-modal-dialog">
            <div class="uk-modal-header uk-alert-success">แจ้งเตือน</div>
            <asp:Label ID="lblAlert" runat="server"></asp:Label>
        </div>
    </div>

    </form>
</body>
</html>
