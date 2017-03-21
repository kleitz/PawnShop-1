<%@ Page Language="VB" AutoEventWireup="false" CodeFile="TicketIn.aspx.vb" Inherits="TicketIn" %>

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
    <script type="text/javascript">
        $(document).ready(function () {
            $('#txtDateStart,#txtDateEnd').datepicker({
                format: "dd/mm/yyyy",
                language: "th-th",
                autoclose: true,
                todayHighlight: true,
                //endDate: '0d'
            });

            loadActivity();

            $('#chkall').change(function () {
                $('tbody tr td input[type="checkbox"]').prop('checked', $(this).prop('checked'));
            });

            $('#ddlEvent').change(function () {
                var eventid = $('#ddlEvent option:selected').val();
                $('#lblActivity').text($('#ddlEvent option:selected').text()).css('color','blue');
                $('#loadingmessage4').show();
                $.ajax({
                    type : "POST", 
                    url: "ajax/getDataOnEvent.aspx",
                    data : "eventid=" +  eventid,
                    dataType : "json" , 
                    success: function (data) {
                        $('#tableDataTicket tbody').empty();
                        for (i = 0 ; i < data.length; i++) {
                            $('#tableDataTicket tbody').append(
                            "<tr>" +
                                "<td style='text-align:center'>" + (i + 1) + "</td>" +
                                "<td style='text-align:center'>" + data[i].TicketId + "</td>" +
                                "<td style='text-align:center'>" + data[i].DateCreated+ "</td>" +
                                "<td style='text-align:center'>" + data[i].Username + "</td>" +
                            "</tr>"
                            );
                        }
                        $('#loadingmessage4').hide();
                    }
                });
            });
        });
        
        function LoadTicketOnEvent() {
            var eventid = $('#ddlEvent option:selected').val();
            $('#lblActivity').text($('#ddlEvent option:selected').text()).css('color', 'blue');
            $('#loadingmessage4').show();
            $.ajax({
                type: "POST",
                url: "ajax/getDataOnEvent.aspx",
                data: "eventid=" + eventid,
                dataType: "json",
                success: function (data) {
                    $('#tableDataTicket tbody').empty();
                    for (i = 0 ; i < data.length; i++) {
                        $('#tableDataTicket tbody').append(
                        "<tr>" +
                            "<td style='text-align:center'>" + (i + 1) + "</td>" +
                            "<td style='text-align:center'>" + data[i].TicketId + "</td>" +
                            "<td style='text-align:center'>" + data[i].DateCreated + "</td>" +
                            "<td style='text-align:center'>" + data[i].Username + "</td>" +
                            "<td style='text-align:center'><input class='chkOut'  type='checkbox' value = '" + data[i].TicketId + "' /></td>" +

                        "</tr>"
                        );
                    }
                    $('#loadingmessage4').hide();
                }
            });
        }


        function LoadTicket() {
            $('#loadingmessage3').show();
            var dateStart = $('#txtDateStart').val();
            var dateEnd = $('#txtDateEnd').val();
            data = "dateStart=" + dateStart + "&dateEnd=" + dateEnd;
            $.ajax({
                type: "POST",
                url : "ajax/LoadTicketForEvent.aspx",
                data : data , 
                dataType : "json",
                success: function (data) {
                    $('#tableData tbody').empty();
                    for (i = 0 ; i < data.length; i++) {
                        $('#tableData tbody').append(
                        "<tr>" +
                            "<td style='text-align:center'>" + (i + 1) + "</td>" +
                            "<td style='text-align:center'>" + data[i].BookNo + "</td>" +
                            "<td style='text-align:center'>" + data[i].TicketNo + "</td>" +
                            "<td style='text-align:center'>" + data[i].TicketStarted + "</td>" +
                            "<td style='text-align:center'><input class='chk'  type='checkbox' value = '" + data[i].TicketId + "' /></td>" +
                        "</tr>"
                         );
                    }
                    $('#loadingmessage3').hide();
                }
            });
        }
        function loadActivity() {
            $.ajax({
                type: "POST",
                url: "ajax/PopualteEvent.aspx",
                contentType: "application/json; charset=utf-8",
                data: {},
                dataType: "json",
                success: function (data) {
                    var ddlEvent = $('#ddlEvent');
                    ddlEvent.empty().append('<option selected="selected" value="">กรุณาเลือกกิจกรรม</option>');
                    $.each(data, function (key, value) {
                        ddlEvent.append($("<option></option>").val(value.EventID).html(value.Detail));
                    });
                },
                error: function ajaxError(result) {
                    alert(result.status + ":" + result.statusText);
                }
            });
        }

        function AddTicketOnEvent() {
            var eventid = $('#ddlEvent').val();
            var allValue = [];
            $('input.chk:checked').each(function () {
                allValue.push($(this).val());
            });

            //console.log(allValue);

            var data = {
                ticket: allValue,
                eventid: eventid
                };
            $.ajax({
                type: "POST",
                url: "ajax/AddTicketOnEvent.aspx",
                data : JSON.stringify(data),
                success: function (data) {
                    if (data == 'success') {
                        $('#tableData tbody').empty();
                        $('#lblAlert').text("นำเข้าตั๋วเรียบร้อย");
                        AlertModal("modalAlertSuccess");
                        LoadTicketOnEvent();
                    }
                }
            });
        }


        function CheckOutTicket() {

        }

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
     <br /><br />
     <div class="uk-form">
     <table class="uk-table">
         <tr>
             <td>
                 <b>เลือกกิจกรรม</b>
             </td>
             <td>
                 <select id="ddlEvent" name="DropdownEvents"></select>
             </td>
         </tr>
         <tr>
             <td>
                 <b> ตั๋วทรัพย์หลุดตั้งแต่วันที่ </b>
             </td>
             <td>
                 
                 <input id="txtDateStart" name="txtDateStart" type="text"  />
             </td>
             <td>
                 <b> ถึงวันที่</b>
             </td>
             <td>
                 
                 <input id="txtDateEnd" name="txtDateEnd" type="text"  />
             </td>
             <td>
                 <input type="button" value="ค้นหา" class="uk-button uk-button-primary" style="color:#ffffff" onclick="LoadTicket()" />
             </td>
         </tr>
     </table>
     </div>

     <hr />

        <div id='loadingmessage3' style='display: none'>
            <img src="img/ajax-loader.gif" />
        </div>
    <table class ="uk-table" border="1" id ="tableData">
        <thead>
            <tr>
                <th style="text-align: center">ลำดับ</th>
                <th style="text-align: center">เลมที่</th>
                <th style="text-align: center">เลขที่</th>
                <th style="text-align: center">วันที่ออกตั๋ว</th>
                <th style="text-align: center"><input type="checkbox" id="chkall" name="chkall"/></th>
            </tr>
        </thead>
        <tbody>

        </tbody>
    </table>
    <button type="button"class="uk-button uk-button-success" style="color:#ffffff" onclick="AddTicketOnEvent()">นำเข้า</button>
    <hr />
        <div id='loadingmessage4' style='display: none'>
        <img src="img/ajax-loader.gif" />
    </div>
    <table class="uk-table">
        <tr>
            <td><b>กิจกรรมและสถานที่</b></td>
            <td>
                <label id="lblActivity"></label>
            </td>
        </tr>
        <tr>
            <td><b>ตั๋วที่มีอยู่ในกิจกรรม</b></td>
        </tr>
    </table>

    <table class="uk-table" border ="1" id ="tableDataTicket">
         <thead>
             <tr>
                 <th style="text-align: center">ลำดับ</th>
                 <th style="text-align: center">เลขตั๋ว</th>
                 <th style="text-align: center">นำเข้าเมื่อวันที่</th>
                 <th style="text-align: center">ผู้ดำเนินการ</th>
                 <th style="text-align: center"><input type="checkbox" id="chkOut" name="chkOut"/></th>
             </tr>
         </thead>
         <tbody>

         </tbody>
    </table>
    <button type="button"class="uk-button uk-button-danger" style="color:#ffffff" onclick="">นำตั๋วออก</button>

    <br /><br /><br />

    <div class="uk-modal" id="modalAlertSuccess">
        <div class="uk-modal-dialog">
            <div class="uk-modal-header uk-alert-success">แจ้งเตือน</div>
            <asp:Label ID="lblAlert" runat="server"></asp:Label>
        </div>
    </div>

    </form>
</body>
</html>
