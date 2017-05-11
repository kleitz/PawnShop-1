<%@ Page Language="VB" AutoEventWireup="false" CodeFile="DefaultManager.aspx.vb" Inherits="DefaultManager" %>

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
            $('#panelEvent').hide();
            $('#lblChooseActivity').hide();
            loadYear();
            loadMonth();

            $('#ddlMonths').change(function () {
                var month = $('#ddlMonths').val();
                var year = $('#ddlyears').val();
                LoadPeriod(month, year);
            });
            

            $('#ddlPeriod').change(function () {
                var year = $('#ddlyears').val();
                var month = $('#ddlMonths').val();
                var period = $('#ddlPeriod').val();
                
                LoadAllInBranchPeriod(year, month, period);
            });

            $('#ddlSelect').change(function () {
                var branchId = $('#hiddenBranch').val();
                var option = $('#ddlSelect option:selected').val();
                switch (option) {
                    case "all":
                        $('#panelEvent').hide();
                        $('#panelPeriod').show();
                        $('#lblChooseActivity').hide();
                        LoadAllInBranch();
                        break;
                    case "byevt":
                        $('#tableData tbody').empty();
                        $('#panelEvent').show();
                        $('#panelPeriod').hide();
                        $('#lblChooseActivity').show();
                        LoadDataByEventByBranchDropDown();
                        break;
                    default:

                }
            });

            $('#ddlEvent').change(function () {

                var eventid = $('#ddlEvent option:selected').val();
                LoadDataByEventByBranch(eventid);

            });


            $('#formEstimate').validate({
                rules: {
                    firstEstimate: {
                        required: true,
                        digits: true
                    }
                },
                messages: {
                    firstEstimate: " กรุณากรอกราคาประเมินและต้องเป็นค่าตัวเลข"
                }
                ,
                submitHandler: function (form) {

                    AlertModal("modalSecret");
                }
            });

        });

        function LoadDataByEventByBranch(eventid) {
            var data = {
                    eventid: eventid
            };
            $('#loading').show();
            $.ajax({
                type: "POST",
                url: "ajax/getDataByEventByBranch.aspx",
                data: JSON.stringify(data),
                dataType : "json",
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    $('#tableData tbody').empty();
                    for (i = 0 ; i < data.length; i++) {
                        $('#tableData tbody').append(
                        "<tr>" +
                            "<td style='text-align:center'>" + (i + 1) + "</td>" +
                            "<td style='text-align:center;display:none'>" + data[i].TicketId + "</td>" +
                            "<td style='text-align:center'>" + data[i].BookNo + "</td>" +
                            "<td style='text-align:center'>" + data[i].TicketNo + "</td>" +
                            "<td style='text-align:center'>" + data[i].periodThaiYearAsset + "</td>" +
                            "<td style='text-align:center'>" + data[i].monthThaiAsset + "</td>" +
                            "<td style='text-align:center'>" + data[i].PeriodNo + "</td>" +
                            "<td style='text-align:center'>" + data[i].Amount + "</td>" +
                            "<td style='text-align:center'>" + "<input id='FirstEstimate' type='text' name='firstEstimate' class='uk-form-width-medium' value='" + data[i].FirstEstimate + "' />" + "</td>" +
                            "<td style='text-align:center'>" + data[i].SecondEstimate + "</td>" +
                            "<td style='text-align:center;display:none;' class='reportNo' >" + data[i].ReportNo + "</td>" +
                            "<td style='text-align:center'><input type='button' value='รายละเอียด' style='color:#ffffff' class='uk-button uk-button-primary' onclick=\"getTicketDetail('" + data[i].TicketId + "')\"/> </td>" +
                            "<td style='text-align:center'><input type='button' value='ประวัติการประเมิน' style='color:#ffffff' class='uk-button uk-button-success' onclick=\"getEstimatDetail('" + data[i].TicketId + "')\"/> </td>" +
                        "</tr>"
                         );
                    }
                    $('#loading').hide();
                },
                error: function ajaxError(result) {
                    alert(result.status + ":" + result.statusText);
                }
            });
        }


        function LoadAllInBranch() {
            $('#loading').show();
            $.ajax({
                type: "POST",
                url: "ajax/Default3.aspx",
                dataType: "json",
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    $('#tableData tbody').empty();

                    for (i = 0 ; i < data.length; i++) {
                        $('#tableData tbody').append(
                        "<tr>" +
                            "<td style='text-align:center'>" + (i + 1) + "</td>" +
                            "<td style='text-align:center;display:none'>" + data[i].TicketId + "</td>" +
                            "<td style='text-align:center;display:none'>" + data[i].BookNo + "</td>" +
                            "<td style='text-align:center;display:none'>" + data[i].TicketNo + "</td>" +
                            "<td style='text-align:center'>" + data[i].BookNo + "/"+  data[i].TicketNo + "</td>" +
                            "<td style='text-align:center'>" + data[i].periodThaiYearAsset + "</td>" +
                            "<td style='text-align:center'>" + data[i].monthThaiAsset + "</td>" +
                            "<td style='text-align:center'>" + data[i].PeriodNo + "</td>" +
                            "<td style='text-align:center'>" + data[i].Amount + "</td>" +
                            "<td style='text-align:center'>" + "<input id='FirstEstimate' type='text' name='firstEstimate' class='uk-form-width-medium' value='" + data[i].FirstEstimate + "' />" + "</td>" +
                            "<td style='text-align:center'>" + data[i].SecondEstimate + "</td>" +
                            "<td style='text-align:center;display:none;' class='reportNo' >" + data[i].ReportNo + "</td>" +
                            "<td style='text-align:center'><input type='button' value='รายละเอียด' style='color:#ffffff' class='uk-button uk-button-primary' onclick=\"getTicketDetail('" + data[i].TicketId + "')\"/> </td>" +
                            "<td style='text-align:center'><input type='button' value='ประวัติการประเมิน' style='color:#ffffff' class='uk-button uk-button-success' onclick=\"getEstimatDetail('" + data[i].TicketId + "')\"/> </td>" +
                        "</tr>"
                         );
                    }
                    $('#loading').hide();
                },
                error: function ajaxError(result) {
                    alert(result.status + ":" + result.statusText);
                }
            });
        }

        function LoadAllInBranchPeriod(year, month, period) {
            data = "year=" + year + "&month=" + month + "&period=" + period; 
            $('#loading').show();
            $.ajax({
                type: "POST",
                url: "ajax/Default4.aspx",
                data: data ,
                dataType: "json",
                success: function (data) {
                    $('#tableData tbody').empty();
                    for (i = 0 ; i < data.length; i++) {
                        $('#tableData tbody').append(
                        "<tr>" +
                            "<td style='text-align:center'>" + (i + 1) + "</td>" +
                            "<td style='text-align:center;display:none'>" + data[i].TicketId + "</td>" +
                            "<td style='text-align:center;display:none'>" + data[i].BookNo + "</td>" +
                            "<td style='text-align:center;display:none'>" + data[i].TicketNo + "</td>" +
                            "<td style='text-align:center'>" + data[i].BookNo + "/" + data[i].TicketNo + "</td>" +
                            "<td style='text-align:center'>" + data[i].periodThaiYearAsset + "</td>" +
                            "<td style='text-align:center'>" + data[i].monthThaiAsset + "</td>" +
                            "<td style='text-align:center'>" + data[i].PeriodNo + "</td>" +
                            "<td style='text-align:center'>" + data[i].Amount + "</td>" +
                            "<td style='text-align:center'>" + "<input id='FirstEstimate' type='text' name='firstEstimate' class='uk-form-width-medium' value='" + data[i].FirstEstimate + "' />" + "</td>" +
                            "<td style='text-align:center'>" + data[i].SecondEstimate + "</td>" +
                            "<td style='text-align:center;display:none;' class='reportNo' >" + data[i].ReportNo + "</td>" +
                            "<td style='text-align:center'><input type='button' value='รายละเอียด' style='color:#ffffff' class='uk-button uk-button-primary' onclick=\"getTicketDetail('" + data[i].TicketId + "')\"/> </td>" +
                            "<td style='text-align:center'><input type='button' value='ประวัติการประเมิน' style='color:#ffffff' class='uk-button uk-button-success' onclick=\"getEstimatDetail('" + data[i].TicketId + "')\"/> </td>" +
                        "</tr>"
                         );
                    }
                    $('#loading').hide();
                },
                error: function ajaxError(result) {
                    alert(result.status + ":" + result.statusText);
                }
            });
        }
        

        function CheckConfirmCode() {

            var code = $('#confirmCode').val();

            $.ajax({
                method: "POST",
                url: "ajax/CheckPrivateCode.aspx",
                data: "confirmcodeval=" + code,
                success: function (data) {
                    if (data == 'OK') {
                        UpdateEstimate();
                      
                       //AlertModal("modalAlertSuccess")
                    } else {
                        alert(data);
                    }
                }
            });

        }


        function UpdateEstimate() {
            var arrData = [];
            $('#tableData tbody tr').each(function () {
                var currentRow = $(this);

                var id = currentRow.find("td:eq(0)").text();
                var TicketId = currentRow.find("td:eq(1)").text();
                var BookNo = currentRow.find("td:eq(2)").text();
                var TicketNo = currentRow.find("td:eq(3)").text();
                //var CreateDate = currentRow.find("td:eq(4)").text();
                var Amount = currentRow.find("td:eq(5)").text();
                var FirstEstimate = currentRow.find('input[name=firstEstimate]').val();
                var SecondEstimate = currentRow.find("td:eq(7)").text();
                var ReportNo = currentRow.find("td:eq(8)").text();

                var obj = {};
                obj.id = id;
                obj.TicketId = TicketId;
                obj.BookNo = BookNo;
                obj.TicketNo = TicketNo;
                //obj.CreateDate = CreateDate;
                obj.Amount = Amount;
                obj.FirstEstimate = FirstEstimate;
                obj.SecondEstimate = SecondEstimate;
                obj.ReportNo = ReportNo;

                arrData.push(obj);
            });
            $.ajax({
                url: "ajax/UpdateEstimate.aspx",
                method: "POST",
                dataType: "json",
                data: JSON.stringify(arrData),
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    if ($.trim(data).toString() == 'Success') {

                    }
                },
            });
            $('#lblAlert').text("ประเมินตั๋วเรียบร้อย");
            AlertModal("modalAlertSuccess");
            //loadGrid();

            var eventid = $('#ddlEvent option:selected').val();
            LoadDataByEventByBranch(eventid);
        }

        function LoadDataByEventByBranchDropDown() {
            $.ajax({
                type: "POST",
                url: "ajax/PopualteEventByBranch.aspx",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data:{},
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

            return false; 
        }

        function getTicketDetail(TicketID) {

            data = "TicketID=" + TicketID;
            $.ajax({
                url: "ajax/DetailTicket.aspx",
                data: data,
                method: "POST",
                dataType: "json",
                success: function (data) {
                    $('#tableDetail tbody').empty();

                    for (i = 0 ; i < data.length; i++) {
                        $('#tableDetail tbody').append(
                        "<tr>" +
                            "<td style='text-align:center'>" + data[i].TicketLine + "</td>" +
                            "<td style='text-align:center'>" + data[i].Name + "</td>" +
                            "<td style='text-align:center'>" + data[i].Description + "</td>" +
                            "<td style='text-align:center'>" + data[i].Quantity + "</td>" +
                        "</tr>"
                         );
                    }
                    AlertModal("modalDetail");
                },
                error: function ajaxError(result) {
                    alert(result.status + ":" + result.statusText);
                }

            });
        }
        function getEstimatDetail(TicketID) {
            data = "TicketID=" + TicketID;
            $.ajax({
                url: "ajax/DetailEstimateLog.aspx",
                data: data,
                method: "POST",
                dataType: "json",
                success: function (data) {
                    $('#tableEstimateDetail tbody').empty();
                    for (i = 0 ; i < data.length; i++) {
                        $('#tableEstimateDetail tbody').append(
                        "<tr>" +
                            "<td style='text-align:center'>" + data[i].EstimateNo + "</td>" +
                            "<td style='text-align:center'>" + data[i].TicketId + "</td>" +
                            "<td style='text-align:center'>" + data[i].Price + "</td>" +
                            "<td style='text-align:center'>" + data[i].UserName + "</td>" +
                            "<td style='text-align:center'>" + data[i].DateCreated + "</td>" +
                        "</tr>"
                         );
                    }
                    AlertModal("modalEstimatelog");
                },
                error: function ajaxError(result) {
                    alert(result.status + ":" + result.statusText);
                }

            });
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

            data = "month=" + month + "&year=" + year;
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


    </script>
</head>
<body>
    <form id="formEstimate" runat="server">
        <asp:HiddenField ID="hiddenBranch" runat ="server"  />
        <br /><br />
        <div class="uk-form">
           <b>ประเมินครั้งที่ 1</b>
            <hr />
           <table class ="uk-table">
               <tr>
                   <td>
                       <b>เลือกข้อมูล</b>
                   </td>
                   <td>
                       <select id="ddlSelect" class="uk-form-width-medium">
                           <option value="">---------กรุณาเลือก---------</option>
                           <option value="all">ทั้งหมดในสาขา</option>
                           <option value="byevt">เลือกตามกิจกรรม</option>
                       </select>
                   </td>
               </tr>
               <tr>
                   <td>
                       <div id="lblChooseActivity">
                           <b>
                               เลือกกิจกรรม
                           </b>
                       </div>
                   </td>
                   <td>
                       <div id="panelEvent">
                           <select id="ddlEvent" name="DropdownEvents"></select>
                       </div>
                   </td>
               </tr>
               <tr>
                   <td></td>
                   <td>
                       <div id="panelPeriod">
                           <b>ปี</b>
                           <select id="ddlyears" name="Dropdownyear"></select>
                           <b>เดือน</b>
                           <select id="ddlMonths" name="DropdownMonth"></select>
                           <b>งวด</b>
                           <select id="ddlPeriod" name="DropdownPeriod"></select>
                       </div>
                   </td>
               </tr>
           </table>

        </div>

        <div class="uk-form">
            <div id='loading' style='display: none'>
                <img src="img/ajax-loader.gif" />
            </div><br />

            <table id="tableData" class="uk-table" border="1">
                <thead>
                    <tr>
                        <td style="text-align: center"><b>ลำดับ</b></td>
                        <td style="text-align: center;display:none">ตั๋ว</td>
                        <td style="text-align: center;display:none">เล่มที่</td>
                        <td style="text-align: center;display:none">เลขที่</td>
                        <td style="text-align: center"><b>เล่มที่/เลขที่</b></td>
                        <td style="text-align: center"><b>ปี</b></td>
                        <td style="text-align: center"><b>เดือน</b></td>
                        <td style="text-align: center"><b>งวด</b></td>
                        <td style="text-align: center"><b>ราคารับจำนำ</b></td>
                        <td style="text-align: center"><b>ประเมินราคาโดยผู้จัดการสาขา</b></td>
                        <td style="text-align: center"><b>ประเมินราคาโดยกรรมการ</b></td>
                        <td style="text-align: center; display: none">ReportNo</td>
                        <td style="text-align: center"><b>รายละเอียดตั๋ว</b></td>
                        <td style="text-align: center"><b>ประวัติการประเมิน</b></td>
                    </tr>
                </thead>
                <tbody>
                </tbody>
            </table>

            <button type="submit" class="uk-button uk-button-success" style="color: #ffffff">Update</button>
        </div>

        <br /><br /><br /><br />

        <div class="uk-modal" id="modalDetail">
            <div class="uk-modal-dialog">
                <div class="uk-modal-header uk-alert-success">รายละเอียดตั๋ว</div>
                <div id="detailTicket">
                     <table id="tableDetail" class="uk-table" border="1">
                         <thead>
                             <tr>
                                 <td style="text-align: center">
                                     ลำดับ
                                 </td>
                                 <td style="text-align: center">
                                     ประเภท
                                 </td>
                                 <td style="text-align: center">
                                     รายละเอียด
                                 </td>
                                 <td style="text-align: center">
                                     จำนวน
                                 </td>
                             </tr>
                         </thead>
                         <tbody>

                         </tbody>
                     </table>
                </div>
            </div>
        </div>

        <div class="uk-modal" id="modalEstimatelog">
            <div class="uk-modal-dialog">
                <div class="uk-modal-header uk-alert-success">รายละเอียดตั๋ว</div>
                <div id="detailTicketEstimate">
                     <table id="tableEstimateDetail" class="uk-table" border="1">
                         <thead>
                             <tr>
                                 <td style="text-align: center">
                                    ประเมินครั้งที่
                                 </td>
                                 <td style="text-align: center">
                                     ตั๋ว
                                 </td>
                                 <td style="text-align: center">
                                     ราคา
                                 </td>
                                 <td style="text-align: center">
                                     ผู้ประเมิน
                                 </td>
                                 <td style="text-align: center">
                                     วันที่
                                 </td>
                             </tr>
                         </thead>
                         <tbody>

                         </tbody>
                     </table>
                </div>
            </div>
        </div>

        <div class="uk-modal" id="modalSecret">
            <div class="uk-modal-dialog">
                <div class="uk-modal-header uk-alert-success">กรุณากรอกรหัสความปลอดภัย</div>
                <div class="uk-form uk-form-horizontal">
                    <table>
                        <tr>
                            <td></td>
                            <td>
                                <input type="password" id="confirmCode" class="uk-form-width-medium" /><input type="button" id="btnPrivateCode" class="uk-button uk-button-success" style="color:#ffffff" value="ยืนยัน" onclick="CheckConfirmCode()" />
                            </td>
                        </tr>
                        <tr>
                            <td></td>
                            <td>
                                <div id='loadingmessage2' style='display: none'>
                                    <img src="img/ajax-loader.gif" />
                                </div>
                            </td>
                            <td>
                                <p id="lblmodal"></p>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
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
