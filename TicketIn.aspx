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
    <style type="text/css">
        .error {
            color: red;
        }
    </style>
    <title>::ระบบจัดการทรัพย์หลุด::</title>
    <script type="text/javascript">
        $(document).ready(function () {

            loadYear();
            loadMonth();
            
            //loadActivity();

            //if ($('#checkEvent').is(':checked')) {
            //    loadActivity();
            //} else {

            //}
            
            $('#checkEvent').change(function () {
                var chk = this.checked ? loadActivity() : '';
            });

            $('#ddlMonths').change(function () {
                var month = $('#ddlMonths').val();
                var year = $('#ddlyears').val();
                LoadPeriod(month, year);
            });

            $('#chkall').change(function () {
                $('#tableData tbody tr td input[type="checkbox"]').prop('checked', $(this).prop('checked'));
            });

            $('#chkOut').change(function () {
                $('#tableDataTicket tbody tr td input[type="checkbox"]').prop('checked', $(this).prop('checked'));
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
                                "<td style='text-align:center;display:none'>" + data[i].TicketId + "</td>" +
                                "<td style='text-align:center'>" + data[i].TicketInfo + "</td>" +
                                "<td style='text-align:center'>" + data[i].monthThaiAsset + "</td>" +
                                "<td style='text-align:center'>" + data[i].periodThaiYearAsset + "</td>" +
                                "<td style='text-align:center'>" + data[i].PeriodNo + "</td>" +
                                "<td style='text-align:center'>" + data[i].periodDay + " " + data[i].monthThai + " " + data[i].periodThaiYear + "</td>" +
                                "<td style='text-align:center'>" + data[i].Username + "</td>" +
                                "<td style='text-align:center'><input class='chkOut' type='checkbox' value = '" + data[i].TicketId + "' /></td>" +
                            "</tr>"
                            );
                        }
                        $('#loadingmessage4').hide();
                    }
                });
            });


            $('#formTicketOnEvent').validate({
                rules: {
                    DropdownEvents: {
                        required: true
                    },
                    Dropdownyear: {
                        required: true
                    },
                    DropdownMonth: {
                        required: true
                    },
                    DropdownPeriod : {
                        required: true
                    }
                }, messages: {
                    DropdownEvents: "กรุณาเลือกกิจกรรม",
                    Dropdownyear: "กรุณาเลือกปี",
                    DropdownMonth: "กรุณเลือกเดือน",
                    DropdownPeriod : "กรุณาเลือกงวด"
        
                }, submitHandler: function (form) {
                    
                    LoadTicket();
                    
                    return false; 
        
                }
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
                            "<td style='text-align:center;display:none'>" + data[i].TicketId + "</td>" +
                            "<td style='text-align:center'>" + data[i].TicketInfo + "</td>" +
                            "<td style='text-align:center'>" + data[i].monthThaiAsset + "</td>" +
                            "<td style='text-align:center'>" + data[i].periodThaiYearAsset + "</td>" +
                            "<td style='text-align:center'>" + data[i].PeriodNo + "</td>" +
                            "<td style='text-align:center'>" + data[i].periodDay + " " + data[i].monthThai + " " + data[i].periodThaiYear + "</td>" +
                            "<td style='text-align:center'>" + data[i].Username + "</td>" +
                            "<td style='text-align:center'><input class='chkOut' type='checkbox' value = '" + data[i].TicketId + "' /></td>" +
                        "</tr>"
                        );
                    }
                    $('#loadingmessage4').hide();
                }
            });
        }


        function LoadTicket() {
            var year = $('#ddlyears').val();
            var month = $('#ddlMonths').val();
            var period = $('#ddlPeriod').val();
            data = "year=" + year + "&month=" + month + "&period=" + period;
            $.ajax({
                type: "POST",
                url: "ajax/LoadTicketForEvent2.aspx",
                data: data,
                dataType: "json",
                success: function (data) {
                    $('#tableData tbody').empty();
                    for (i = 0 ; i < data.length; i++) {
                        $('#tableData tbody').append(
                        "<tr>" +
                            "<td style='text-align:center'>" + (i + 1) + "</td>" +
                            "<td style='text-align:center;display:none'>" + data[i].TicketId + "</td>" +
                            "<td style='text-align:center'>" + data[i].BookNo + "/" + data[i].TicketNo + "</td>" +
                            "<td style='text-align:center'>" + data[i].periodDay + " " + data[i].monthThai + " " + data[i].periodThaiYear + "</td>" +
                            "<td style='text-align:center'><input class='chk'  type='checkbox' value = '" + data[i].TicketId + "' /></td>" +
                        "</tr>"
                            );
                    }
                    $('#loadingmessage3').hide();
                }
            });

            $("#chkall").prop("checked", false);
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


        function loadYear() {
            $.ajax({
                type: "POST",
                url: "ajax/LoadYear.aspx",
                contentType: "application/json; charset=utf-8",
                data: {},
                dataType: "json",
                success: function (data) {
                    var ddlyears = $('#ddlyears');
                    ddlyears.empty().append('<option selected="selected" value="">กรุณาเลือกปี</option>');
                    $.each(data, function (key, value) {
                        ddlyears.append($("<option></option>").val(value.periodYear).html(value.periodThaiYear));
                    });
                },
                error: function ajaxError(result) {
                    alert(result.status + ":" + result.statusText);
                }
            });
        }

        function loadMonth() {
            $.ajax({
                type: "POST",
                url: "ajax/LoadMonth.aspx",
                contentType: "application/json; charset=utf-8",
                data: {},
                dataType: "json",
                success: function (data) {
                    var ddlMonths = $('#ddlMonths');
                    ddlMonths.empty().append('<option selected="selected" value="">กรุณาเลือกเดือน</option>');
                    $.each(data, function (key, value) {
                        ddlMonths.append($("<option></option>").val(value.periodMonth).html(value.monthThai));
                    });
                },
                error: function ajaxError(result) {
                    alert(result.status + ":" + result.statusText);
                }
            });
        }

        function LoadPeriod(month, year) {

            data = "month=" + month + "&year=" + year ;
            $.ajax({
                url: "ajax/LoadPeriod2.aspx",
                contentType: "application/json; charset=utf-8",
                data: data,
                dataType: "json",
                success: function (data) {
                    var ddlPeriod = $('#ddlPeriod');
                    ddlPeriod.empty().append('<option selected="selected" value="">กรุณาเลือกงวด</option>');
                    $.each(data, function (key, value) {
                        ddlPeriod.append($("<option></option>").val(value.PeriodNo).html(value.PeriodNo));
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

            if (allValue.length == 0) {
                $('#lblAlert').text("กรุณาเลือกตั๋วที่จะนำเข้า");
                AlertModal("modalAlertSuccess");
                return; 
            } else {
                var data = {
                    ticket: allValue,
                    eventid: eventid
                };
                $.ajax({
                    type: "POST",
                    url: "ajax/AddTicketOnEvent.aspx",
                    data: JSON.stringify(data),
                    success: function (data) {
                        if (data == 'success') {
                            $('#tableData tbody').empty();
                            $('#lblAlert').text("นำเข้าตั๋วเรียบร้อย");
                            AlertModal("modalAlertSuccess");
                            LoadTicketOnEvent();
                        }
                    }
                });
                $("#chkall").prop("checked", false);
            }

        }


        function CheckOutTicket() {
            var eventid = $('#ddlEvent').val();
            var allCheckOut = [];
            $('input.chkOut:checked').each(function () {
                allCheckOut.push($(this).val());
            });
            
            if (allCheckOut.length == 0) {
                $('#lblAlert').text("กรุณาเลือกตั๋วที่จะนำออก");
                AlertModal("modalAlertSuccess");
                return;
            } else {
                var data = {
                    ticket: allCheckOut,
                    eventid: eventid
                };

                $.ajax({
                    type: "POST",
                    url: "ajax/CheckOutTicket.aspx",
                    data: JSON.stringify(data),
                    success: function (data) {
                        if (data == 'success') {
                            $('#tableDataTicket tbody').empty();
                            $('#lblAlert').text("นำตั๋วออกเรียบร้อย");
                            AlertModal("modalAlertSuccess");
                            LoadTicketOnEvent();
                        }
                    }
                });

                $("#chkOut").prop("checked", false);
            }
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
    <form id="formTicketOnEvent" runat="server">
     <br /><br />
     <div class="uk-form">
     <table class="uk-table">
         <tr>
             <td>
                 <b>เลือกกิจกรรม</b>
                 <select id="ddlEvent" name="DropdownEvents"></select>&nbsp;&nbsp;
                 <input type="checkbox" name="checkEvent" id="checkEvent"/>&nbsp;&nbsp;<b>รวมกิจกรรมที่ผ่านมาแล้ว</b>
             </td>
         </tr>
         <tr>
             <td>
                 <b>ปี</b>
                 <select id="ddlyears" name="Dropdownyear"></select>
                 <b>เดือน</b>
                 <select id="ddlMonths" name="DropdownMonth"></select>
                 <b>งวด</b>
                 <select id="ddlPeriod" name="DropdownPeriod"></select>
                 <button id="btnSearch" class="uk-button uk-button-primary" type="submit" style="color: #ffffff" >ค้นหา</button>
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
                <th style="text-align: center;display:none">เลขตั๋ว</th>
                <th style="text-align: center">เล่มที่/เลขที่</th>
                <th style="text-align: center">วันที่ออกตั๋ว</th>
                <th style="text-align: center">
                <input type="checkbox" id="chkall" name="chkall" /></th>
            </tr>
        </thead>
        <tbody>

        </tbody>
    </table>
    <button type="button" class="uk-button uk-button-success" style="color:#ffffff" onclick="AddTicketOnEvent()">นำเข้า</button>
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
                 <th style="text-align: center">เล่มที่/เลขที่</th>
                 <th style="text-align: center">เดือน</th>
                 <th style="text-align: center">ปี</th>
                 <th style="text-align: center">งวดที่</th>
                 <th style="text-align: center">นำเข้าเมื่อวันที่</th>
                 <th style="text-align: center">ผู้ดำเนินการ</th>
                 <th style="text-align: center"><input type="checkbox" id="chkOut" name="chkOut"/></th>
             </tr>
         </thead>
         <tbody>

         </tbody>
    </table>
    <button type="button"class="uk-button uk-button-danger" style="color:#ffffff" onclick="CheckOutTicket()">นำตั๋วออก</button>

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
