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

            $('#ddlEvent').change(function () {
                //var branchId = $('#hiddenBranch').val();
                var eventid = $('#ddlEvent option:selected').val();

                LoadDataByEventByBranch(eventid);
                //alert(eventid);

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
                            "<td style='text-align:center'>" + data[i].TicketId + "</td>" +
                            "<td style='text-align:center'>" + data[i].BookNo + "</td>" +
                            "<td style='text-align:center'>" + data[i].TicketNo + "</td>" +
                            "<td style='text-align:center'>" + data[i].CreatedDate + "</td>" +
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
                            "<td style='text-align:center'>" + data[i].TicketId + "</td>" +
                            "<td style='text-align:center'>" + data[i].BookNo + "</td>" +
                            "<td style='text-align:center'>" + data[i].TicketNo + "</td>" +
                            "<td style='text-align:center'>" + data[i].CreatedDate + "</td>" +
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

    </script>
</head>
<body>
    <form id="formEstimate" runat="server">
        <asp:HiddenField ID="hiddenBranch" runat ="server"  />
        <br /><br />
        <div class="uk-form">
            <br />
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
           </table>

        </div>

        <div class="uk-form">
            <div id='loading' style='display: none'>
                <img src="img/ajax-loader.gif" />
            </div><br />

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
    </form>
</body>
</html>
