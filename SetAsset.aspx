<%@ Page Language="VB" AutoEventWireup="false" CodeFile="SetAsset.aspx.vb" Inherits="SetAsset" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <script type="text/javascript" src="js/jquery.js"></script>
    <script src="js/uikit.min.js" type="text/javascript"></script>
    <script src="js/jquery.validate.js"></script>
    <script src="js/components/notify.min.js"></script>
    <link href="css/uikit.min.css" rel="stylesheet" type="text/css" />
    <link href="css/GridStyle.css" rel="stylesheet" />
    <title>::ระบบจัดการทรัพย์หลุด::</title>
    <style type="text/css">
        .error {
            color: red;
        }
    </style>
    <script type="text/javascript">

        $(document).ready(function () {

            $("#txtTicketNumber").keydown(function (e) {
                if (e.which == 17 || e.which == 74) {
                    e.preventDefault();
                } else {
                    console.log(e.which);
                }
            });

            $('#txtTicketNumber').focus();
            $('#totalQty').val(0);
            $('#totalWeight').val(0);
            $('#totalAmt').val(0);
            $('#totalEstimate').val(0);
            $('#setEdit').hide();
            loadSet();
            loadProductType();
            loadEvent();

            $('#closeEdit').click(function () {
                $('#setEdit').hide();
            });

            $('#form1').validate({
                rules: {
                    DropdownCategory: {
                        required: true
                    },
                    DropdownEvent: {
                        required: true
                    }
                },
                messages: {
                    DropdownCategory: " กรุณาเลือกประเภทชุดก่อน ",
                    DropdownEvent: " กรุณาเลือกกิจกรรม "
                },
                submitHandler: function (form) {
                    //alert("xxx");
                    AddSet();
                    return false;
                }

            });
        });
        
        function loadProductType() {

            $.ajax({
                type: "POST",
                url: "ajax/PopulateProductType.aspx",
                contentType: "application/json; charset=utf-8",
                data: {},
                dataType: "json",
                success: function (data) {
                    var ddlCategory = $('#dropdowCate');
                    ddlCategory.empty().append('<option selected="selected" value="">กรุณาเลือกประเภท</option>');
                    $.each(data, function (key, value) {
                        ddlCategory.append($("<option></option>").val(value.ProductTypeId).html(value.Name));
                    });
                },
                error: function ajaxError(result) {
                    alert(result.status + ":" + result.statusText);
                }

            });
        }
        function loadEvent() {
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


        function AlertModal(ModalName) {
            var modalName = "#" + ModalName;
            var modal = UIkit.modal(modalName);

            if (modal.isActive()) {
                modal.hide();
            } else {
                modal.show();
            }
        }

        function alertModalSelect() {
            AlertModal("modalSelectBefore");
        }

        function AddTicketFromScanner(event) {
            var x = event.which || event.keyCode;
            var message = "";
            if (x == 13) {
                if ($("#txtTicketNumber").val().length > 0) {
                    AddTicket();
                } else {
                    $('#txtTicketNumber').focus();
                }
            }
        }


        function AddTicket() {
            var ticketId = $('#txtTicketNumber').val().trim();
            var arr = $('#tableData tbody tr').find('td:first').map(function () {
                return $(this).text()
            }).get();

            if (ticketId == "") {
                $('#lblAlert').text("กรุณากรอกเลขตั๋ว");
                AlertModal("modalAlertSuccess");
                return;
            }

            var fLen = arr.length;
            for (i = 0; i < fLen; i++) {
                if (arr[i] == ticketId) {
                    $('#lblAlert').text("มีตั๋วนี้อยู่แล้ว");
                    AlertModal("modalAlertSuccess");
                    return; 
                }
            }

            CheckTicket(ticketId);

        }

        function loadAddTicket(ticketId) {
            data = "TicketID=" + ticketId;
            $.ajax({
                type: "POST",
                url: "ajax/BeforSet.aspx",
                data: data,
                dataType: "json",
                success: function (data) {
                    $('#tableData tbody').append(
                        "<tr>" +
                            "<td style='text-align:center'>" + data[0].TicketId + "</td>" +
                            "<td style='text-align:center'>" + '' + "</td>" +
                            "<td style='text-align:center'>" + data[0].TicketNo + "</td>" +
                            "<td style='text-align:center'>" + data[0].BookNo + "</td>" +
                            "<td class = 'qty' style='text-align:center' >" + data[0].Quantity + "</td>" +
                            "<td class = 'weight' style='text-align:center' >" + data[0].Weight + "</td>" +
                            "<td class = 'amount' style='text-align:center' >" + data[0].Amount + "</td>" +
                            "<td class = 'estimate' style='text-align:center' >" + data[0].Estimate + "</td>" +
                            "<td>" + "<input id='btnDelete' type='button' class='del uk-button uk-button-primary' style='color:#ffffff' value = 'ลบข้อมูล' onClick='deleteRow(this)'/>" + "</td>" +
                        "</tr>"
                        );

                    deleteRow = function (element) {
                        $(element).parent().parent().remove();
                        loadSum();
                    }
                    loadSum();

                }
            });
        }


        function CheckTicket(tid)
        {
            data = "tid=" + tid;
            $.ajax({
                url: "ajax/CheckTicketID.aspx",
                method : "POST",
                data: data,
                success: function (data) {
                    if (data == 'Success') {
                        loadAddTicket(tid);
                        $('#txtTicketNumber').val("");
                    } else {
                        $('#lblAlert').text("ไม่พบข้อมูล");
                        $('#txtTicketNumber').val("");
                        AlertModal("modalAlertSuccess");
                    }
                }
            });
        }
        function loadSum() {
            $(document).ready(function () {
                var sumQty = 0;
                var sumWeight = 0;
                var sumAmt = 0;
                var sumEstimate = 0;

                $('.qty').each(function () {
                    var value = parseFloat($(this).text().replace(/[^0-9]/g, ''));
                    if (!isNaN(value) && value.length != 0) {
                        sumQty += parseFloat(value);
                    }
                });

                $('.weight').each(function () {
                    var value = parseFloat($(this).text().replace(/[^0-9]/g, ''));
                    if (!isNaN(value) && value.length != 0) {
                        sumWeight += parseFloat(value);
                    }
                });

                $('.amount').each(function () {
                    var value = parseFloat($(this).text().replace(/[^0-9]/g, ''));
                    if (!isNaN(value) && value.length != 0) {
                        sumAmt += parseFloat(value);
                    }
                });

                $('.estimate').each(function () {
                    var value = parseFloat($(this).text().replace(/[^0-9]/g, ''));
                    if (!isNaN(value) && value.length != 0) {
                        sumEstimate += parseFloat(value);
                    }
                });

                $('#totalQty').val(sumQty);
                $('#totalWeight').val(sumWeight);
                $('#totalAmt').val(sumAmt);
                $('#totalEstimate').val(sumEstimate);

            });
        }


        function AddSet() {
            var arr = $('#tableData tbody tr').find('td:first').map(function () {
                return $(this).text()
            }).get();

            var totalQty = $('#totalQty').val();
            var totalweight = $('#totalWeight').val();
            var totalAmt = $('#totalAmt').val();
            var totalEstimate = $('#totalEstimate').val();
            var event_id = $('#ddlEvent').val();
            var category = $('#dropdowCate').val();

            var data = {
                Tickets: arr,
                qty : totalQty , 
                weight : totalweight,
                amt :  totalAmt,
                estimate: totalEstimate,
                eventId : event_id ,
                category : category
            };

            if (totalQty == 0.00 || totalAmt == 0.00 || totalEstimate == 0.00) {
                $('#lblAlert').text("กรุณาตรวจสอบข้อมูลผลรวม");
                AlertModal("modalAlertSuccess");

            } else {
                $.ajax({
                    url: "ajax/SetAsset.aspx",
                    method: "POST",
                    data: JSON.stringify(data),
                    success :  function(data){
                        //$('#showSet').html(data);
                        loadSet();
                        $('#totalQty').val("")
                        $('#totalWeight').val("");
                        $('#totalAmt').val("");
                        $('#totalEstimate').val("");
                    }
                });
            }
            $('#tableData tbody').empty();
            loadSet();
        }

        function commaSeparateNumber(val) {
            while (/(\d+)(\d{3})/.test(val.toString())) {
                val = val.toString().replace(/(\d+)(\d{3})/, '$1' + ',' + '$2');
            }
            return val;
        }
        function loadSet() {
            $.ajax({
                url: "ajax/SetAll.aspx",
                method: "POST",
                dataType : "json",
                success: function (data) {
                    $('#tableSet tbody').empty();
                    for (i = 0 ; i < data.length; i++) {
                        $('#tableSet tbody').append(
                        "<tr>" +
                            "<td style='text-align:center;display: none'>" + data[i].ID + "</td>" +
                            "<td style='text-align:center'>" + data[i].No + "</td>" +
                            "<td style='text-align:center'>" + data[i].ProductName + "</td>" +
                            "<td style='text-align:center'>" + data[i].Name + "</td>" +
                            "<td style='text-align:center'>" + data[i].Quantity + "</td>" +
                            "<td style='text-align:center'>" + data[i].Weight + "</td>" +
                            "<td style='text-align:center'>" + data[i].PriceSum + "</td>" +
                            "<td style='text-align:center'>" + data[i].SecondEstimate + "</td>" +
                            "<td style='text-align:center'>" + data[i].UserName + "</td>" +
                            "<td style='text-align:center'>" + data[i].DateCreated + "</td>" +
                            "<td style='text-align:center'><input type='button' value='ตั๋วในชุด' class='uk-button uk-button-success' onclick=\"getTicketSet('" + data[i].ID + "')\"/> </td>" +
                            "<td style='text-align:center'><input type='button' value='แก้ไขชุด' class='uk-button uk-button-primary' onclick=\"EditSet('" + data[i].ID + "')\"/> </td>" +
                            "<td style='text-align:center'><input type='button' value='ลบ' class='uk-button uk-button-danger' onclick=\"AlertDelSet('" + data[i].ID + "')\"/> </td>" +
                        "</tr>"
                         );
                    }
                }
            });
        }

        function AlertDelSet(id) {
            $('#hddDelSetId').val(id);

            AlertModal("modalAlertDelSet");
        }
        function getTicketSet(id) {
            data = "id=" + id;
            $.ajax({
                url: "ajax/getTicketInSet.aspx",
                data : data,
                method: "POST",
                dataType: "json",
                success: function (data) {
                    $('#tableTicketInSet tbody').empty();
                    for (i = 0 ; i < data.length; i++) {
                        $('#tableTicketInSet tbody').append(
                            "<tr>" +
                            "<td style='text-align:center;display:none'>" + data[i].SetID + "</td>" +
                            "<td style='text-align:center'>" + data[i].TicketId + "</td>" +
                            "</tr>"
                        );
                    }
                    AlertModal("modalAlertTicketInset");
                }
            });
        }


        function EditSet(id) {
            //$('#setEdit').show();

            AlertModal("modalEdit");
            loadSetChild(id);

            data = "id=" + id; 
            $.ajax({
                url: "ajax/LoadDetailSet.aspx",
                method: "POST",
                data: data,
                dataType: "json",
                success: function (data) {
                    $('#hUsername').val(data[0].Username);
                    $('#hSetID').val(data[0].ID);

                    $('#lblBranch').text(data[0].Name).css('color', 'green');
                    $('#lblSetNo').text(data[0].No);
                    $('#lblWeight').val(data[0].Weight);
                    $('#PriceSum').val(data[0].PriceSum);
                    $('#PriceEstimate').val(data[0].SecondEstimate);
                }
            });
        }

        function loadSetChild(SetNo) {

            $('#tableChild tbody').empty();
           
            var data = "SetNo=" + SetNo;
            $.ajax({
                url: "ajax/LoadChild.aspx",
                method: "POST",
                data: data,
                dataType:  "json",
                success: function (data) {
                    for (i = 0 ; i < data.length; i++) {
                        $('#tableChild tbody').append(
                        "<tr>" +
                            "<td style='text-align:center;display: none'>" + data[i].SetID + "</td>" +
                            "<td style='text-align:center'>" + data[i].TicketId + "</td>" +
                            "<td style='text-align:center'>" + data[i].Username + "</td>" +
                            "<td style='text-align:center'><input style='color:#ffffff' type='button' value='ลบ' class='uk-button uk-button-danger' onclick=\"DeleteChild('" + data[i].SetID + "')\"/> </td>" +
                            "<td style='text-align:center;display:none'><input id='hddTicket' type='hidden' value = '" + data[i].TicketId + "' /></td>" +
                        "</tr>"
                        );
                    }
                }
            });
        }
        function DeleteChild(SetID) {
            var TicketID = $('#hddTicket').val();
            data = "SetID=" + SetID + "&TicketID=" + TicketID;
            $.ajax({
                url: "ajax/DeleteChild.aspx",
                data: data,
                method: "POST",
                success: function (data) {
                    if (data == 'Success') {
                        loadSetChild(SetID);
                    }
                }
            });
        }

        function DeleteSet() {
            var id = $('#hddDelSetId').val();
            data = "SetID=" + id;
            $.ajax({
                url: "ajax/DeleteSet.aspx",
                data: data,
                method: "POST",
                success: function (data) {
                    if (data == "Success") {
                        $('#lblAlert').text("ลบเรียบร้อย");
                        AlertModal("modalAlertSuccess");
                        loadSet();
                    } else {
                        $('#lblAlert').text("ไม่สามารถลบได้");
                        AlertModal("modalAlertSuccess");
                    }
                }
            });
        }
    </script>
</head>
<body>
    <form id="form1" name="form1" >
<%--        <asp:HiddenField ID="hddBranch" runat="server" />
        <asp:HiddenField ID="hddMonth" runat="server" />
        <asp:HiddenField ID="hddYear" runat="server" />--%>

<%--        <asp:Panel ID="panelInsertSet" runat="server" Visible="true">--%>
            <div class="uk-form">
                <table class="uk-table uk-table-condensed">
                    <tr>
                        <td>
                            <b>เลขตั๋ว</b>
                        </td>
                        <td>
                            <input type="text" id="txtTicketNumber" onkeypress="AddTicketFromScanner(event)" />
                            <%--<input type="button" value="add" class="uk-button uk-button-success" onclick="AddTicket()" style="color:#ffffff" />--%>             
                        </td>
                    </tr>
                    <tr>
                        <td><b>ประเภทชุด</b></td>
                        <td>
                            <select id="dropdowCate" name="DropdownCategory"></select>
                            
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <b>เลือกกิจกรรม</b>
                        </td>
                        <td>
                            <select id="ddlEvent" name="DropdownEvent"></select>
                            
                        </td>
                    </tr>
                    <tr>
                        <td></td>
                        <td>
                            <%--<input type="submit" value="จัดชุด" class="uk-button uk-button-success" onclick="AddSet()" style="color: #ffffff" />--%>
<%--                            <button type="submit" class="uk-button uk-button-success"  style="color: #ffffff">จัดชุด</button>--%>

                            <button id="btnAddSet" class="uk-button uk-button-success" type="submit" style="color: #ffffff" >จัดชุด</button>    
   
                        </td>
                    </tr>
                </table>
                <table id="tableData" class="uk-table" border="1">
                    <thead>
                        <tr>
                            <th style="text-align: center">เลขตั๋ว</th>
                            <th style="text-align: center">ประเภท</th>
                            <th style="text-align: center">เลขที่</th>
                            <th style="text-align: center">เล่มที่</th>
                            <th style="text-align: center">จำนวน</th>
                            <th style="text-align: center">น้ำหนัก(กรัม)</th>
                            <th style="text-align: center">ราคารับจำนำ(บาท)</th>
                            <th style="text-align: center">ราคาประเมิน(บาท)</th>
                            <th style="text-align: center">ลบ</th>
                        </tr>
                    </thead>
                    <tbody>
                    </tbody>
                    <tfoot>
                        <tr>
                            <td style="text-align: center"><b>รวม</b></td>
                            <td></td>
                            <td></td>
                            <td style="text-align: center">
                                <input id="totalQty" type="text" />
                            </td>
                            <td style="text-align: center">
                                <input id="totalWeight" type="text" />
                            </td>
                            <td style="text-align: center">
                                <input id="totalAmt" type="text" />
                            </td>
                            <td style="text-align: center">
                                <input id="totalEstimate" type="text" />
                            </td>
                        </tr>
                    </tfoot>
                </table>
            </div>
<%--        </asp:Panel>--%>
        <br />
        <br />



        <b>รายการชุดที่จัดไว้แล้ว</b>
        <hr />
        <table id="tableSet" class="uk-table" border="1">
            <thead>
                <tr>
                    <th style="text-align: center; display: none">ID</th>
                    <th style="text-align: center">เลขชุด</th>
                    <th style="text-align: center">ประเภทชุด</th>
                    <th style="text-align: center">สาขา</th>
                    <th style="text-align: center">จำนวนสิ่ง</th>
                    <th style="text-align: center">น้ำหนัก</th>
                    <th style="text-align: center">ราคารับจำนำรวม</th>
                    <th style="text-align: center">ราคาประเมิน</th>
                    <th style="text-align: center">ผู้ทำรายการ</th>
                    <th style="text-align: center">วันที่ทำการจัดชุด</th>
                    <th style="text-align: center">ตั๋วที่มีอยู่ในชุด</th>
                    <th style="text-align: center">แก้ไข</th>
                    <th style="text-align: center">ลบ</th>
                </tr>
            </thead>
            <tbody>
            </tbody>
        </table>
        <br /><br /><br /><br /><br />             
    <div class="uk-modal" id="modalAlertSuccess">
        <div class="uk-modal-dialog">
            <div class="uk-modal-header uk-alert-success">แจ้งเตือน</div>
            <asp:Label ID="lblAlert" runat="server"></asp:Label>
        </div>
    </div>

    <div class="uk-modal" id="modalAlertTicketInset">
        <div class="uk-modal-dialog">
            <div class="uk-modal-header uk-alert-success">ตั๋วที่มีอยู่ในชุดนี้</div>
            <table id="tableTicketInSet" class="uk-table">
                <thead>
                    <tr>
                       <td style="text-align: center;display:none">
                           ชุดที่
                       </td>
                       <td style="text-align: center">
                           ตั๋ว
                       </td>
                    </tr>
                </thead>
                <tbody>

                </tbody>
            </table>
        </div>
    </div>
    <div class="uk-modal" id="modalAlertDelSet">
        <div class="uk-modal-dialog">
            <a class="uk-modal-close uk-close"></a>
            <div class="uk-modal-header uk-alert-danger">ต้องการยกเลิกชุด ?</div>
            <table class="uk-table">
                <tr>
                    <td>
                        <input type="hidden" id="hddDelSetId" />
                        <input type="button" value="ยืนยันการลบ" class="uk-button uk-button-primary uk-modal-close" style="color: #ffffff" onclick="DeleteSet()" />
                    </td>
                </tr>
            </table>
        </div>
    </div>
    </form>
    <script type="text/javascript">
        $(document).ready(function (data) {
            $('#form2').validate({
                rules: {
                    weight :{
                        required: true,
                        digits: true
                    },
                    priceSum: {
                        required: true,
                        digits: true
                    },
                    PriceEstimate : {
                        required: true,
                        digits: true
                    }
                },
                messages: {
                    weight: " กรุณากรอกน้ำหนักและต้องเป็นค่าตัวเลข",
                    priceSum: " กรุณากรอกราคารวมและต้องเป็นค่าตัวเลข",
                    PriceEstimate: "กรุณากรอกราคาประเมินและต้องเป็นค่าตัวเลข"
                }
                ,
                submitHandler: function (form) {
                    UpdateDetailSet();
                    //form.submit();
                }
            });

            $('#closeEdit').click(function () {
                var validator = $("#form2").validate();
                validator.resetForm();
            });
            //$('#conFirmEdit').click(function () {
            //    UpdateDetailSet();
            //    $(this).addClass('uk-modal-close');
            //});

            $('#AddTicketOnEvnet').click(function () {
                var ticketid = $('#txtAddTicketOnEvent').val().trim();
                var setID = $('#hSetID').val();
                var username = $('#hUsername').val();

                if (ticketid == '') {
                    //$('#lblAlert').text("กรุณากรอกข้อมูล");
                    //AlertModal("modalAlertSuccess");
                    $('#lblAlertTicketStatus').text("กรุณากรอกข้อมูล").css('color', 'red');
                    return; 
                }
                   
                checkTicket(ticketid);

            });

            function AddChild(SetID, TicketId, Username) {
              
                data = "SetID=" + SetID + "&TicketId=" + TicketId + "&Username=" + Username;
                $.ajax({
                    url: "ajax/AddChild.aspx",
                    data: data,
                    method: "POST",
                    success: function (data) {
                        loadSetChild(SetID);
                        $('#txtAddTicketOnEvent').val("");
                    }
                });
            }


            function UpdateDetailSet() {
                var SetID = $('#hSetID').val();
                var weight = $('#lblWeight').val();
                var priceSum = $('#PriceSum').val();
                var priceEstimate = $('#PriceEstimate').val();
                
                data = {
                    SetID: SetID,
                    Weight: weight,
                    PriceSum: priceSum,
                    PriceEstimate: priceEstimate
                };
                
                $.ajax({
                    url: "ajax/UpdateDetailSet.aspx",
                    method: "POST",
                    data: JSON.stringify(data),
                    success: function (data) {
                        if (data == 'Success') {
                            $('#lblAlert').text("แก้ไขเรียบร้อย");
                            AlertModal("modalAlertSuccess");
                            loadSet();
                        }
                    }
                });
            }
            function checkTicket(tid) {
                data = "tid=" + tid;
                var setID = $('#hSetID').val();
                var username = $('#hUsername').val();

                $.ajax({
                    url: "ajax/CheckTicketID.aspx",
                    method: "POST",
                    data: data,
                    success: function (data) {
                        if (data == 'Success') {
                            AddChild(setID, tid, username);
                            $('#lblAlertTicketStatus').text("");
                        } else {
                            $('#txtAddTicketOnEvent').val("");
                            $('#lblAlertTicketStatus').text("ไม่พบตั๋วหรืออาจมีข้อมูลอยู่แล้ว").css('color','red');
                        }
                    }
                });
            }
        });
       

    </script>
    <style type="text/css">
        .error {
            color: red;
        }
    </style>
    <form id="form2">
        <div class="uk-modal" id="modalEdit" style="width:1600px">
            <div class="uk-modal-dialog">
                <div class="uk-modal-header uk-alert-warning">รายการชุดที่แก้ไข</div>
                <input type="hidden" id="hUsername" />
                <input type="hidden" id="hSetID" />
                <input type="hidden" id="hTicketId" />
                <div class="uk-form">
                    <table id="tableSetEdit" class="uk-table">
                        <tr>
                            <td>
                                <b>เลขชุด</b>
                            </td>
                            <td>
                                <label id="lblSetNo"></label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <b>สาขา</b>
                            </td>
                            <td>
                                <label id="lblBranch"></label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <b>น้ำหนัก</b>
                            </td>
                            <td>
                                <input type="text" id="lblWeight" name="weight" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <b>ราคารับจำนำรวม</b>
                            </td>
                            <td>
                                <input type="text" id="PriceSum" name="priceSum" />
                            </td>

                        </tr>
                        <tr>
                            <td>
                                <b>ราคาประเมิน</b>
                            </td>
                            <td>
                                <input type="text" id="PriceEstimate" name ="PriceEstimate" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <b>เพิ่มตั่ว</b>
                            </td>
                            <td>
                                <input type="text" id="txtAddTicketOnEvent" />
                                <input id="AddTicketOnEvnet" type="button" value="+" class="uk-button uk-button-primary" style="color: #ffffff" />
                                <label id="lblAlertTicketStatus"></label>
                            </td>
                            <td></td>
                        </tr>
                        <tr>
                            <td></td>
                            <td>
                                <table id="tableChild" class="uk-table" border="1">
                                    <thead>
                                        <tr>
                                            <td style="text-align: center; display: none">EventID</td>
                                            <td style="text-align: center">เลขตั๋ว</td>
                                            <td style="text-align: center">ผู้ทำรายการ</td>
                                            <td style="text-align: center">ลบ</td>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    </tbody>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td></td>
                            <td>
                                <button id="conFirmEdit" class="uk-button uk-button-success" type="submit" style="color: #ffffff" >ยืนยันการแก้ไข</button>
                                <input id="closeEdit" type="button" class="uk-button uk-button-danger uk-modal-close" value="ปิดการแก้ไข" style="color: #ffffff" />
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
