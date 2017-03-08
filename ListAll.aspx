<%@ Page Language="VB" AutoEventWireup="false" CodeFile="ListAll.aspx.vb" Inherits="ListAll" %>

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
            loadSet();
            loadTray();
        });

        function loadSet() {
            $.ajax({
                url: "ajax/SetAllDisplay.aspx",
                method: "POST",
                dataType: "json",
                success: function (data) {
                    for (i = 0 ; i < data.length; i++) {
                        $('#tableSet tbody').append(
                        "<tr>" +
                            "<td style='text-align:center;display: none'>" + data[i].ID + "</td>" +
                            "<td style='text-align:center'>" + data[i].No + "</td>" +
                            "<td style='text-align:center'>" + data[i].Name + "</td>" +
                            "<td style='text-align:center'>" + data[i].PriceSum + "</td>" +
                            "<td style='text-align:center'>" + data[i].SecondEstimate + "</td>" +
                            "<td style='text-align:center'>" + data[i].BranchName + "</td>" +
                            "<td style='text-align:center'>" + data[i].IsSaled + "</td>" +

                        "</tr>"
                         );
                    }
                }
            });
        }

        function loadTray() {
            $.ajax({
                url: "ajax/TrayAllDisplay.aspx",
                method: "POST",
                dataType: "json",
                success: function (data) {
                    for (i = 0 ; i < data.length; i++) {
                        $('#tableTray tbody').append(
                        "<tr>" +
                            "<td style='text-align:center;display: none'>" + data[i].ID + "</td>" +
                            "<td style='text-align:center'>" + data[i].TrayNo + "</td>" +
                            "<td style='text-align:center'>" + data[i].GroupName + "</td>" +
                            "<td style='text-align:center'>" + data[i].Amount + "</td>" +
                            "<td style='text-align:center'>" + data[i].Estimate + "</td>" +
                            "<td style='text-align:center'>" + data[i].BranchName + "</td>" +
                            "<td style='text-align:center'>" + data[i].IsSaled + "</td>" +

                        "</tr>"
                         );
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
            <b>รายการทรัพย์หลุดทั้งหมด</b>
            <hr />
            รายการถาด<br />
            <table id="tableTray" class="uk-table" border ="1">
                <thead>
                    <tr>
                        <td style="text-align: center;display:none">ID</td>
                        <td style="text-align: center">เลขถาด</td>
                        <td style="text-align: center">ประเภทถาด</td>
                        <td style="text-align: center">ราคารวม</td>
                        <td style="text-align: center">ราคาประเมินล่าสุด</td>
                        <td style="text-align: center">สาขา</td>
                        <td style="text-align: center">สถานะ</td>
                    </tr>
                </thead>
                <tbody>
                </tbody>
            </table>
            <br />
            รายการชุด
            <br />
            <table id="tableSet" class="uk-table" border ="1">
                <thead>
                    <tr>
                        <td style="text-align: center;display:none">ID</td>
                        <td style="text-align: center">เลขชุด</td>
                        <td style="text-align: center">ประเภทชุด</td>
                        <td style="text-align: center">ราคารวม</td>
                        <td style="text-align: center">ราคาประเมินล่าสุด</td>
                        <td style="text-align: center">สาขา</td>
                        <td style="text-align: center">สถานะ</td>
                    </tr>
                </thead>
                <tbody>
                </tbody>
            </table>   
        </div>
    </form>
</body>
</html>
