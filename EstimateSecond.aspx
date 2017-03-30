<%@ Page Language="VB" AutoEventWireup="false" CodeFile="EstimateSecond.aspx.vb" Inherits="EstimateSecond" %>

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
            $('#panelBranch').hide();
            $('#lblChooseActivity').hide();

            $('#ddlSelect').change(function () {
                var branchId = $('#hiddenBranch').val();
                var option = $('#ddlSelect option:selected').val();
                switch (option) {
                    case "all":
                        $('#panelEvent').hide();
                        $('#lblChooseActivity').hide();
                        LoadAllInBranch();
                        break;
                    case "byevt":
                        $('#tableData tbody').empty();
                        $('#panelEvent').show();
                        $('#lblChooseActivity').show();
                        LoadDataByEventByBranchDropDown();
                        break;
                    default:

                }
            });
        });





        function LoadDataByEventByBranchDropDown() {
            $.ajax({
                type: "POST",
                url: "ajax/PopualteEventByBranch.aspx",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: {},
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
                            "<td style='text-align:center'>" + data[i].TicketId + "</td>" +
                            "<td style='text-align:center'>" + data[i].BookNo + "</td>" +
                            "<td style='text-align:center'>" + data[i].TicketNo + "</td>" +
                            "<td style='text-align:center'>" + data[i].CreatedDate + "</td>" +
                            "<td style='text-align:center'>" + data[i].Amount + "</td>" +
                            "<td style='text-align:center'>" + data[i].FirstEstimate + "</td>" +
                            "<td style='text-align:center'>" + "<input id='SecondEstimate' type='text' name='secondEstimate' class='uk-form-width-medium' value='" + data[i].SecondEstimate + "' />" + "</td>" +
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
    </script>
</head>
<body>
    <form id="formSecondEstimate" runat="server">
    <div>
        <asp:HiddenField ID="hiddenBranch" runat ="server"  />
        <br /><br />
        <div class="uk-form">
           <b>ประเมินครั้งที่ 2</b>
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
                       <div id="panelBranch">
                           <select id="ddlBranch" name="DropdownBranch"></select>
                       </div>
                   </td>
               </tr>
           </table>

        </div>


        <div class="uk-form">
            <div id='loading' style='display: none'>
                <img src="img/ajax-loader.gif" />
            </div>
            <br />

            <table id="tableData" class="uk-table" border="1">
                <thead>
                    <tr>
                        <td style="text-align: center">ลำดับ</td>
                        <td style="text-align: center">ตั๋ว</td>
                        <td style="text-align: center">เล่มที่</td>
                        <td style="text-align: center">เลขที่</td>
                        <td style="text-align: center">เดือน</td>
                        <td style="text-align: center">ราคารับจำนำ</td>
                        <td style="text-align: center">ประเมินราคาครั้งที่หนึ่ง</td>
                        <td style="text-align: center">ประเมินราคาครั้งที่สอง</td>
                        <td style="text-align: center; display: none">ReportNo</td>
                        <td style="text-align: center">รายละเอียดตั๋ว</td>
                        <td style="text-align: center">ประวัติการประเมิน</td>
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
                                <input type="password" id="confirmCode" class="uk-form-width-medium" /><input type="button" id="btnPrivateCode" class="uk-button uk-button-success" style="color: #ffffff" value="ยืนยัน" onclick="CheckConfirmCode()" />
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


    </div>
    </form>
</body>
</html>
