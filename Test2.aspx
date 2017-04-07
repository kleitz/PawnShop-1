<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Test2.aspx.vb" Inherits="Test2" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <script src="js/jquery.js"></script>

    <script type="text/javascript" language="javascript" src="https://cdn.datatables.net/1.10.13/js/jquery.dataTables.min.js"></script>
    <link href="https://cdn.datatables.net/1.10.13/css/jquery.dataTables.min.css" rel="stylesheet" />
    <script type="text/javascript">
        $(document).ready(function () {
            LoadQueue();
            
        });

        function LoadQueue() {

            $.ajax({
                Type: "POST",
                url: "ajax/loadQueue.aspx",
                data: {},
                dataType: "json",
                success: function (data) {
                    console.log(data);
                    $('#tableData tbody').empty();
                    for (i = 0 ; i < data.length; i++) {
                        $('#tableData tbody').append(
                        "<tr>" +
                            "<td style='text-align:center;'>" + (i + 1) + "</td>" +
                            "<td style='text-align:center;'>" + data[i].BookNo + "/" + data[i].TicketNo + "</td>" +
                        "</tr>"
                         );
                    }
                    $('#tableData').DataTable();
                }
                ,
                error: function ajaxError(result) {
                    alert(result.status + ":" + result.statusText);
                }
            });
        }
    </script>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <table>
                <tr>
                    <td>จำนวนรายการทั้งหมด&nbsp;&nbsp;&nbsp;
                    </td>
                    <td>
                        <asp:Label ID="lblCnt" runat="server"></asp:Label>
                    </td>
                    <td>&nbsp;&nbsp;&nbsp;รายการ
                    </td>
                </tr>
            </table>
        </div>
        <div class="uk-form">
            <table id="tableData" class="uk-table" border="1">
                <thead>
                    <tr>
                        <td style="text-align: center"></td>
                        <td style="text-align: center">เล่ม/เลข</td>
                        <td style="text-align: center">ตั๋ววันที่</td>
                        <td style="text-align: center">ชื่อลูกค้า</td>
                        <td style="text-align: center">ประเภทงาน</td>
                        <td style="text-align: center">เมื่อ</td>
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
