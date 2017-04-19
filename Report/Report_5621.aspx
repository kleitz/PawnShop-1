<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Report_5621.aspx.vb" Inherits="Report_5621" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link href="../css/uikit.min.css" rel="stylesheet" />
    <script src="../js/jquery.js"></script>
    <script src="../js/jquery.validate.js"></script>
    <script src="../js/uikit.min.js"></script>
    <title></title>

    <script type ="text/javascript">
        $(document).ready(function () {
            LoadAllBranch();

            $('#ddlMonth').change(function () {
                var branchId = $('#ddlBranch').val();
                var month = $('#ddlMonth').val();
                var year = $('#ddlyear').val();
                LoadPeriod(branchId, month, year);
            });

            $('#btnGenReport').click(function () {
                var branch = $('#ddlBranch').val();
                var period = $('#ddlperiod').val();
                var month = $('#ddlMonth').val();
                var year = $('#ddlyear').val();

                window.open("ajax/Create5621.aspx?branch=" + branch + "&period=" + period + "&month=" + month + "&year=" + year);
              
                return false; 
            });
        });

        function LoadAllBranch() {
            $.ajax({
                url: "ajax/LoadBranchAll.aspx",
                contentType: "application/json; charset=utf-8",
                data: {},
                dataType: "json",
                success: function (data) {
                    var ddlBranch = $('#ddlBranch');
                    ddlBranch.empty().append('<option selected="selected" value="">กรุณาเลือกสาขา</option>');
                    $.each(data, function (key, value) {
                        ddlBranch.append($("<option></option>").val(value.BranchId).html(value.Name));
                    });
                },
                error: function ajaxError(result) {
                    alert(result.status + ":" + result.statusText);
                }
            });
        }
        function LoadPeriod(branch,month, year) {
            //var year = year - 543;
            data = "month=" + month + "&year=" + year + "&branch=" + branch;
            $.ajax({
                url: "ajax/LoadPeriod.aspx",
                contentType: "application/json; charset=utf-8",
                data: data,
                dataType: "json",
                success: function (data) {
                    var ddlperiod = $('#ddlperiod');
                    ddlperiod.empty().append('<option selected="selected" value="">กรุณาเลือกงวด</option>');
                    $.each(data, function (key, value) {
                        ddlperiod.append($("<option></option>").val(value.PeriodNo).html(value.PeriodNo));
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
    <form id="form1" runat="server">

    <h3>บัญชีประเมินราคาทรัพย์หลุดเป็นกรรมสิทธิ์</h3>

    <div class="uk-form">
        <table>
            <tr>
                <td>
                    สาขา :
                    
                </td>
                <td>
                    <select id="ddlBranch" name="DropdAllBranch" ></select>
                     ปี
                    <select id="ddlyear">
                        <option value="2017">2560</option>
                        <option value="2016">2559</option>
                        <option value="2015">2558</option>
                        <option value="2014">2557</option>
                        <option value="2013">2556</option>
                    </select>
                </td>
                <td>เดือน
                </td>
                <td>
                    <select id="ddlMonth" name="DropDownMonth">
                        <option value="01">มกราคม</option>
                        <option value="02">กุมภาพันธ์</option>
                        <option value="03">มีนาคม</option>
                        <option value="04">เมษายน</option>
                        <option value="05">พฤษภาคม</option>
                        <option value="06">มิถุนายน</option>
                        <option value="07">กรกฎาคม</option>
                        <option value="08">สิงหาคม</option>
                        <option value="09">กันยายน</option>
                        <option value="10">ตุลาคม</option>
                        <option value="11">พฤษจิกายน</option>
                        <option value="12">ธันวาคม</option>
                    </select>
                    งวดที่ :
                    <select id="ddlperiod" name="DropDownPeriod"></select>
                    <button id="btnGenReport" class="uk-button uk-button-primary" style="color: #ffffff">ออกรายงาน</button>
                </td>
            </tr>
        </table>
    </div>
    <div id='loadingmessage7' style='display: none'>
        <img src="img/ajax-loader.gif" />
    </div>
    <div id="ReportContent">

    </div>
    </form>
</body>
</html>
