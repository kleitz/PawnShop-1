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
            
            $('#ddlSelect').change(function () {
                var eventid = $('#ddlSelect option:selected').val();

            });
        });

        function LoadDataByEventByBranch(branchId) {
           //var branchId = $('#hiddenBranch').val();
            data = "branchId=" + branchId; 
            $.ajax({
                type: "POST",
                url: "ajax/PopualteEventByBranch.aspx",
                contentType: "application/json; charset=utf-8",
                data: data,
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

    </script>
</head>
<body>
    <form id="formEstimate" runat="server">
        <asp:HiddenField ID="hiddenBranch" runat ="server"  />
        <br /><br />
        <div class="uk-form">
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
