<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Managetray.aspx.vb" Inherits="Managetray" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <script type="text/javascript" src="js/jquery.js">
    <script src="js/jquery.validate.js"></script>
    <script src="js/uikit.min.js" type="text/javascript"></script>
    <script src="js/components/notify.js"></script>
    <link href="css/uikit.min.css" rel="stylesheet" type="text/css" />
    <link href="css/GridStyle.css" rel="stylesheet" />
    <title>::ระบบจัดการทรัพย์หลุด::</title>
    <script type="text/javascript">
        $(document).ready(function () {
            $('#TotalWeight').val(0);
            $('#TotalAmt').val(0);
            $('#TotalEstimate').val(0);
           
            loadSet();
            loadCategory();
            loadActivity();
            loadTray();

            $('#btnSetTray').click(function () {
                AddTray(); 
            });


        });

        function loadCategory() {
            $.ajax({
                type: "POST",
                url: "ajax/PopualateCategory.aspx",
                contentType: "application/json; charset=utf-8",
                data: {},
                dataType: "json",
                success: function (data) {
                    var ddlCategory = $('#dropdowCategory')
                    ddlCategory.empty().append('<option selected="selected" value="0">กรุณาเลือกประเภท</option>');
                    $.each(data, function (key, value) {
                        ddlCategory.append($("<option></option>").val(value.ID).html(value.GroupName));
                    });
                },
                error: function ajaxError(result) {
                    alert(result.status + ":" + result.statusText);
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
                    ddlEvent.empty().append('<option selected="selected" value="0">กรุณาเลือกกิจกรรม</option>');
                    $.each(data, function (key, value) {
                        ddlEvent.append($("<option></option>").val(value.EventID).html(value.Detail));
                    });
                },
                error: function ajaxError(result) {
                    alert(result.status + ":" + result.statusText);
                }
            });
        }


        function AddTray() {
            var arr = $('#tableSet tbody tr input:checked').map(function () {
                return $(this).val();
            }).get();

 
            var category = $('#dropdowCategory').val();
            var weight = $('#TotalWeight').val();
            var priceSum = $('#TotalAmt').val();
            var second_Estimate = $('#TotalEstimate').val();
            var eventid = $('#ddlEvent').val();

            var data = {
                SetId: arr,
                Category: category,
                Weight: weight,
                PriceSum: priceSum,
                SecondEstimate: second_Estimate,
                EventID: eventid
            };

            $.ajax({
                url: "ajax/SetTray.aspx",
                method: "POST",
                data: JSON.stringify(data),
                success: function (data) {
                    if (data == 'Success') {
                        loadSet();
                        loadTray();

                        $('#TotalWeight').val("");
                        $('#TotalAmt').val("");
                        $('#TotalEstimate').val("");
                    }
                },
                error: function ajaxError(result) {
                    alert(result.status + ":" + result.statusText);
                }
            });

        }

        function loadTray() {
            //alert('xxx');
            $.ajax({
                url: "ajax/LoadTray.aspx",
                contentType: "application/json; charset=utf-8",
                Type: "POST",
                dataType: "json",
                success: function (data) {
                    console.log(data);
                    $('#tableTray tbody').empty();
                    for (var i = 0 ; data.length ; i++) {
                        $('#tableTray tbody').append(
                            "<tr>" +
                                "<td style='text-align:center;display: none'>" + data[i].ID + "</td>" +
                                "<td style='text-align:center'>" + data[i].TrayNo + "</td>" +
                                "<td style='text-align:center'>" + data[i].GroupName + "</td>" +
                                "<td style='text-align:center'>" + data[i].Amount + "</td>" +
                                "<td style='text-align:center'>" + data[i].Estimate + "</td>" +
                                "<td style='text-align:center'>" + data[i].Name + "</td>" +
                                "<td style='text-align:center'><input type='button' value='แก้ไขถาด' class='uk-button uk-button-primary' style='color:#ffffff' onclick=\"EditTray('" + data[i].ID + "')\"/> </td>" +
                                "<td style='text-align:center'><input type='button' value='ลบ' class='uk-button uk-button-danger' style='color:#ffffff' onclick=\"AlertEditTray('" + data[i].ID + "')\"/> </td>" +
                            "</tr>"
                         );
                    }
                }
                ,
                error: function ajaxError(result) {
                    alert(result.status + ":" + result.statusText);
                }
            });
        }
        function AlertEditTray(id) {

            $('#hddDelTrayId').val(id);
            AlertModal("modalAlertDelTray");

        }

        function deleteTray() {

            var id = $('#hddDelTrayId').val();
            data = "id=" + id; 
            $.ajax({
                url: "ajax/UpdateTray.aspx",
                data: data,
                method: "POST",
                success: function(data) {
                    if (data == 'Success') {
                        $('#lblAlert').text("ลบเรียบร้อย");
                        AlertModal("modalAlertSuccess");
                        loadTray();
                    }

                }
            });
        }

        function loadDropDownForEdit() {
            $.ajax({
                type: "POST",
                url: "ajax/PopualateCategory.aspx",
                contentType: "application/json; charset=utf-8",
                data: {},
                dataType: "json",
                success: function (data) {
                    var ddlCategory = $('#ddlCategory');
                    ddlCategory.empty().append('<option value="0">กรุณาเลือกประเภท</option>');
                    $.each(data, function (key, value) {
                        ddlCategory.append($("<option></option>").val(value.ID).html(value.GroupName));

                    });
                },
                error: function ajaxError(result) {
                    alert(result.status + ":" + result.statusText);
                }
            });
        }

        function EditTray(id) {
            loadDropDownForEdit();
            data = "id=" + id; 
            $.ajax({
                url: "ajax/EditTray.aspx",
                data :data ,
                method: "POST",
                dataType: "json",
                success: function (data) {
                    $('#hddTrayId').val(data[0].ID);
                    $('#lblTrayNo').text(data[0].TrayNo);
                    $('#ddlCategory').val(data[0].ProductGroupID);
                    $('#lblsum').val(data[0].Amount);
                    $('#lblEstimate').val(data[0].Estimate);
                    AlertModal("modalAlertEdit");

                }
            });
            
        }

        function confirmEdit() {
            var trayid = $('#hddTrayId').val();
            var cagtegory = $('#ddlCategory').val();
            var amt = $('#lblsum').val();
            var estimateSet = $('#lblEstimate').val();
            
            data = {
                TrayID: trayid,
                Category: cagtegory,
                Amount: amt,
                Estimate: estimateSet
            };

            $.ajax({
                url: "ajax/UpdateTrayDetail.aspx",
                method: "POST",
                data: JSON.stringify(data),
                success: function (data) {
                    if (data == "Success") {
                        $('#lblAlert').text("แก้ไขเรียบร้อยแล้ว");
                        AlertModal("modalAlertSuccess");
                        loadTray();
                    } else {
                        $('#lblAlert').text("ไม่สามารถแก้ไขได้");
                        AlertModal("modalAlertSuccess");
                    }
                }
            });
        }
       
        function loadSet() {
            $.ajax({
                url: "ajax/SetAll.aspx",
                method: "POST",
                dataType: "json",
                success: function (data) {
                    $('#tableSet tbody').empty();
                    for (i = 0 ; i < data.length; i++) {
                        $('#tableSet tbody').append(
                        "<tr>" +
                            "<td style='text-align:center;display: none'>" + data[i].ID + "</td>" +
                            "<td style='text-align:center'>" + data[i].No + "</td>" +
                            "<td style='text-align:center'>" + data[i].ProductName + "</td>" +
                            "<td style='text-align:center'>" + data[i].Name + "</td>" +
                            "<td style='text-align:center' class = 'qty'>" + data[i].Quantity + "</td>" +
                            "<td style='text-align:center' class = 'Weight'>" + data[i].Weight + "</td>" +
                            "<td style='text-align:center' class = 'PriceSum'>" + data[i].PriceSum + "</td>" +
                            "<td style='text-align:center' class = 'SecondEstimate'>" + data[i].SecondEstimate + "</td>" +
                            "<td style='text-align:center'>" + data[i].UserName + "</td>" +
                            "<td style='text-align:center'>" + data[i].DateCreated + "</td>" +
                            "<td style='text-align:center'><input class='chk'  type='checkbox' value = '" + data[i].ID  + "' /></td>" +
                        "</tr>"
                         );
                    }

                    $('input:checkbox').click(function (e) {

                        var cntColumn = 8;
                        for (var i = 6 ; i <= cntColumn ; i++) {
                            findSum(i, i);
                        }
                    });
                }
            });
        }
        function findSum(ColID,index) {
            total = 0;
            $("#tableSet tbody tr:has(:checkbox:checked) td:nth-child(" + ColID + ")").each(function () {
                total += parseFloat($(this).text());
            });

            if (index == 6) {
                $('#TotalWeight').val(total);
            } else if (index == 7) {
                $('#TotalAmt').val(total);
            } else if (index == 8) {
                $('#TotalEstimate').val(total);
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
    <form id="form1" runat="server">
        <div class="uk-form">
            <br />
            <br />
            <b>จัดถาด</b><br />
            <hr />
            <table>
                <tr>
                    <td>เลือกประเภท
                    </td>
                    <td>
                        <select id="dropdowCategory" name="DropdownCategory"></select>
                    </td>
                </tr>
                <tr>
                    <td>เลือกกิจกรรม
                    </td>
                    <td>
                        <select id="ddlEvent" name="DropdownEvent"></select>
                        <input id="btnSetTray" type="button" class="uk-button uk-button-primary" value="จัดถาด" style="color: #ffffff" />
                    </td>
                </tr>
            </table>



            <table id="tableSet" class="uk-table" border="1">
                <thead>
                    <tr>
                        <th style="text-align: center; display: none">ID</th>
                        <th style="text-align: center">เลขชุด</th>
                        <th style="text-align: center">ประเภทชุด</th>
                        <th style="text-align: center">สาขา</th>
                        <th style="text-align: center">จำนวนสิ่ง</th>
                        <th style="text-align: center">น้ำหนัก</th>
                        <th style="text-align: center">ราคารับจำนำรวม(บาท)</th>
                        <th style="text-align: center">ราคาประเมินรวมล่าสุด(บาท)</th>
                        <th style="text-align: center">ผู้ทำการจัดชุด</th>
                        <th style="text-align: center">วันที่ทำการจัดชุด</th>
                        <th style="text-align: center">เลือก</th>
                    </tr>
                </thead>
                <tbody>
                </tbody>
                <tfoot>
                    <tr>
                        <td colspan="4" style="text-align: center"><b>รวม</b></td>
                        <td style="text-align: center">
                            <input type="text" id="TotalWeight" class="uk-form-width-medium " /></td>
                        <td style="text-align: center">
                            <input type="text" id="TotalAmt" class="uk-form-width-medium" /></td>
                        <td style="text-align: center">
                            <input type="text" id="TotalEstimate" class="uk-form-width-medium" /></td>
                    </tr>
                </tfoot>
            </table>
            <br />
            <br />
            <b>ถาดที่จัดไว้แล้ว</b><br />
            <hr />
            <table id="tableTray" class="uk-table" border="1">
                <thead>
                    <tr>
                        <th style="text-align: center; display: none;">ID</th>
                        <th style="text-align: center">เลขถาด</th>
                        <th style="text-align: center">ประเภทถาด</th>
                        <th style="text-align: center">ราคารวม</th>
                        <th style="text-align: center">ราคาประเมินล่าสุด</th>
                        <th style="text-align: center">สาขา</th>
                        <th style="text-align: center">แก้ไข</th>
                        <th style="text-align: center">ยกเลิกถาด</th>
                    </tr>
                </thead>
                <tbody>
                </tbody>
            </table>
            <br />
            <br />
            <br />
        </div>

        <div class="uk-modal" id="modalAlertDelTray">
            <div class="uk-modal-dialog">
                <a class="uk-modal-close uk-close"></a>
                <div class="uk-modal-header uk-alert-danger">ต้องการยกเลิกถาด ?</div>
                <table class="uk-table">
                    <tr>
                        <td>
                            <input type="hidden" id="hddDelTrayId" />
                            <input type="button" value="ยืนยันการลบ" class="uk-button uk-button-primary uk-modal-close" style="color: #ffffff" onclick="deleteTray()" />
                        </td>
                    </tr>
                </table>
            </div>
        </div>
        <div class="uk-modal" id="modalAlertSuccess">
            <div class="uk-modal-dialog">
                <div class="uk-modal-header uk-alert-success">แจ้งเตือน</div>
                <asp:Label ID="lblAlert" runat="server"></asp:Label>
            </div>
        </div>

    </form>
   
    <form id="form2">
        <script src="js/jquery.validate.js"></script>
        <script type="text/javascript">
            $(document).ready(function () {
                $('#form2').validate({
                    rules: {
                        SumAmt: {
                            required: true,
                            digits : true
                        },
                        Estimate: {
                            required: true,
                            digits: true
                        }
                    },
                    messages: {  
                        SumAmt: " กรุณากรอกราคารวมและต้องเป็นค่าตัวเลข",
                        Estimate: " กรุณากรอกราคาประเมินและต้องเป็นค่าตัวเลข"
                    }
                    ,
                    submitHandler: function (form) {
                        confirmEdit();
                        //form.submit();
                    }
                });

                

            //$('#btnConfirmEdit').click(function () {
            //    confirmEdit();
            //});
            $('#btnClose').click(function () {
                var validator = $("#form2").validate();
                validator.resetForm();
            });

            });

        </script>
        <style type="text/css">
            .error {
                color: red;
            }
        </style>
        <div class="uk-modal" id="modalAlertEdit">
            <div class="uk-modal-dialog">
                <div class="uk-modal-header uk-alert-success">รายละเอียดของถาด</div>
                <div class="uk-form">
                    <table class="uk-table">
                        <tr>
                            <td>
                                <b>เลขถาด</b>
                            </td>
                            <td>
                                <label id="lblTrayNo"></label>
                                <input type="hidden" id="hddTrayId" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <b>ประเภทถาด</b>
                            </td>
                            <td>
                                <select id="ddlCategory" name="DropdownCategory"></select>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <b>ราคารวม</b>
                            </td>
                            <td>
                                <input id="lblsum"  name="SumAmt" type="text" class="uk-form-width-medium required"  />
                            </td>
                            <td>
                                <label id="alretSum"></label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <b>ราคาประเมิน</b>
                            </td>
                            <td>
                                <input id="lblEstimate" name="Estimate" type="text" class="uk-form-width-medium " />
                            </td>
                            <td>
                                <label id="alertEstimate"></label>
                            </td>
                        </tr>
                        <tr>
                            <td></td>
                            <td>
                                <button id="btnConfirmEdit" class="uk-button uk-button-success" type="submit" style="color: #ffffff" >ยืนยันการแก้ไข</button>                           
                                <input id="btnClose" type="button" value="ยกเลิก" class="uk-button uk-button-danger uk-modal-close" style="color: #ffffff" />
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
        <div class="uk-modal" id="modalDetailTray">
            <div class="uk-modal-dialog">
                <div class="uk-modal-header uk-alert-success">รายละเอียดของถาด</div>
                <b>ชุดที่อยู่ในถาด</b>
                <div class="uk-form">
                    <table class="uk-table">
                        <thead>
                            <tr>
                                <th></th>
                                <th></th>
                                <th></th>
                                <th></th>
                                <th></th>
                                <th></th>
                            </tr>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>

                </div>
            </div>
        </div>

    </form>
</body>
</html>
