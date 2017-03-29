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

        });
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
