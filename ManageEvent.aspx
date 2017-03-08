<%@ Page Language="VB" AutoEventWireup="false" CodeFile="ManageEvent.aspx.vb" Inherits="ManageEvent" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
   <script type="text/javascript" src="js/jquery.js">
    <script src="js/jquery.validate.js"></script>
    <script src="js/uikit.min.js" type="text/javascript"></script>
    <script src="js/components/notify.js"></script>
    <link href="css/uikit.min.css" rel="stylesheet" type="text/css" />
    <link href="css/GridStyle.css" rel="stylesheet" />
    <title>::ระบบจัดการทรัพย์หลุด::</title>
    <script type="text/javascript">
        $(document).ready(function () {
            loadEventAll();
        });

        function loadEventAll() {
            $.ajax({
                url : "ajax/GetAllEvent.aspx",
                method: "POST",
                dataType: "json",
                success: function (data) {
                    $('#tableEvent tbody').empty();
                    for (i = 0 ; i < data.length; i++) {
                        $('#tableEvent tbody').append(
                        "<tr>" +
                            "<td style='text-align:center;display: none'>" + data[i].EventID + "</td>" +
                            "<td style='text-align:center'>" + data[i].EventNo + "</td>" +
                            "<td style='text-align:left'>" + data[i].fDateEventStart + "</td>" +
                            "<td style='text-align:left'>" + data[i].TIME + "</td>" +
                            "<td style='text-align:left'>" + data[i].BranchName + "</td>" +
                            (data[i].isEnable == 1 ? "<td style='text-align:center'><input type='button' value='Off' style='color:#ffffff' class='uk-button uk-button-danger' onclick=\"UpdateIsEnableEvent('" + data[i].EventID + "',0)\"/></td>" : "<td style='text-align:center'><input type='button' value='On' style='color:#ffffff' class='uk-button uk-button-success' onclick=\"UpdateIsEnableEvent('" + data[i].EventID + "',1)\"/></td>") +
                        "</tr>"
                         );
                    }
                }
            });
        }

        function UpdateIsEnableEvent(id,status) {
            data = "id=" + id + "&status=" + status;
            $.ajax({
                url: "ajax/UpdateIsEnableEvent.aspx",
                method: "POST",
                data: data,
                success: function (data) {
                    if (data == 'Success') {
                        loadEventAll();
                    }
                }
            });
        }

    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div class="uk-form">
        <br />
        <br />
        <b>จัดการกิจกรรม</b><br />
        <hr />
        <table class="uk-table" id="tableEvent" border="1">
            <thead>
                <tr>
                    <th>เลขประกาศ</th>
                    <th>วันที่จัดกิจกรรม</th>
                    <th>เวลา</th>
                    <th>สถานที่จัด</th>
                    <th>จัดการ</th>
                </tr>
            </thead>
            <tbody>

            </tbody>
        </table>

        <br /><br /><br />
    </div>
    </form>
</body>
</html>
