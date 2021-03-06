﻿<%@ Page Language="VB" AutoEventWireup="false" CodeFile="CommitteeController.aspx.vb" Inherits="AuctionArea_CommitteeController" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Untitled Document</title>
    <link href="../Bootstrap/Content/bootstrap.css" rel="stylesheet" />
    <link href="../Bootstrap/Content/font-awesome.min.css" rel="stylesheet" />
    <script src="../Bootstrap/Scripts/jquery-3.1.1.js" type="text/javascript"></script>
    <script src="../Bootstrap/Scripts/jquery.validate.min.js" type="text/javascript"></script>
    <script src="../Bootstrap/Scripts/bootstrap.min.js" type="text/javascript"></script>
    <script src="../Bootstrap/Scripts/moment.js"></script>
    <script src="../Bootstrap/Scripts/datepicker-thai/bootstrap-datepicker.js"></script>
    <script src="../Bootstrap/Scripts/datepicker-thai/bootstrap-datepicker-thai.js"></script>
    <script src="../Bootstrap/Scripts/datepicker-thai/locales/bootstrap-datepicker.th.js"></script>
    <link href="../Bootstrap/css/pagination_ys.css" rel="stylesheet" />
    <link href="../Bootstrap/css/datapicker/datepicker3.css" rel="stylesheet" />
    <link href="../Bootstrap/css/Grid.css" rel="stylesheet" />
    <script>
        $(document).ready(function () {
            jQuery.validator.addMethod("notEqualToGroup", function(value, element, options) {
                var elems = $(element).parents('form').find(options[0]);
                var valueToCompare = value;
                var matchesFound = 0;
                jQuery.each(elems, function(){
                    thisVal = $(this).val();
                    if(thisVal == valueToCompare){
                        matchesFound++;
                    }
                });
                if(this.optional(element) || matchesFound <= 1) {
                    elems.removeClass('error');
                    return true;
                } else {
                    elems.addClass('error');
                }
            }, "ห้ามเลือกรายชื่อซ้ำกันค่ะ");

            $("#comittFrm").validate({
                rules: {
                    commit0: {
                        required: true,
                        notEqualToGroup: ['.distinctCommit']
                    },
                    commit1: {
                        required: true,
                        notEqualToGroup: ['.distinctCommit']
                    },
                    commit2: {
                        required: true,
                        notEqualToGroup: ['.distinctCommit']
                    },
                    commit3: {
                        required: true,
                        notEqualToGroup: ['.distinctCommit']
                    },
                    commit4: {
                        required: true,
                        notEqualToGroup: ['.distinctCommit']
                    },
                    commit5: {
                        required: true,
                        notEqualToGroup: ['.distinctCommit']
                    },
                    commit6: {
                        required: true,
                        notEqualToGroup: ['.distinctCommit']
                    },
                    commit7: {
                        required: true,
                        notEqualToGroup: ['.distinctCommit']
                    },
                    commit8: {
                        required: true,
                        notEqualToGroup: ['.distinctCommit']
                    },
                    commit9: {
                        required: true,
                        notEqualToGroup: ['.distinctCommit']
                    },
                    branch0: {
                        required: true,
                        notEqualToGroup: ['.distinctBranch']
                    },
                    branch1: {
                        required: true,
                        notEqualToGroup: ['.distinctBranch']
                    },
                    branch2: {
                        required: true,
                        notEqualToGroup: ['.distinctBranch']
                    },
                    branch3: {
                        required: true,
                        notEqualToGroup: ['.distinctBranch']
                    },
                    branch4: {
                        required: true,
                        notEqualToGroup: ['.distinctBranch']
                    },
                    branch5: {
                        required: true,
                        notEqualToGroup: ['.distinctBranch']
                    },
                    branch6: {
                        required: true,
                        notEqualToGroup: ['.distinctBranch']
                    },
                    branch7: {
                        required: true,
                        notEqualToGroup: ['.distinctBranch']
                    },
                    branch8: {
                        required: true,
                        notEqualToGroup: ['.distinctBranch']
                    },
                    branch9: {
                        required: true,
                        notEqualToGroup: ['.distinctBranch']
                    },
                    announcer0: {
                        required: true,
                        notEqualToGroup: ['.distinctAnnouncer']
                    },
                    announcer1: {
                        required: true,
                        notEqualToGroup: ['.distinctAnnouncer']
                    },                    
                    officer0: {
                        required: true,
                        notEqualToGroup: ['.distinctOffice']
                    },
                    officer1: {
                        required: true,
                        notEqualToGroup: ['.distinctOffice']
                    },
                },
                messages: {
                    "select[]": "Please select",
                },
                submitHandler: function() {
                    var memberTypeId = 0;
                    var rownum = getMaxRowNum();
                    var announcerId = $("#announcer0").val() + "|" +  $("#announcer1").val();
                    var officialId = $("#officer0").val() + "|" +  $("#officer1").val();
                    for (i = 0; i <= committNum; i++) {
                        if (i >= 3) {
                            memberTypeId = 4;

                        } else {
                            memberTypeId = i + 1;
                        }
                        for (j = 0 ; j <= branchNum; j++) {
                            //alert($("#commit" + i).val() + "," + $("#branch" + j).val());
                            addDataToDB(v_eventId, memberTypeId, $("#commit" + i).val(), $("#branch" + j).val(), rownum , announcerId , officialId);
                        }
                    }
                    alert("บันทึกข้อมูลเรียบร้อย");
                    LoadDefault(v_eventId);
                    $('#myModal').modal('hide');
                    LoadDropdownDefault();
                    return false;
                }
            });
        });


    </script>
    <style>
        label.error, label.error {
            color: red;
            font-style: italic;
        }
    </style>
</head>

<body>
    <div class="container-fluid">
        <header class="page-header">
            <h3><i class="fa fa-file-text-o " aria-hidden="true"></i>&nbsp;ข้อมูลคณะกรรมการดำเนินการจำหน่ายทรัพย์หลุดจำนำและเจ้าหน้าที่เสนอทรัพย์หลุดจำนำ</h3>
        </header>
        <div class="row">
            <div class="col-md-12">
                <h4>ประกาศที่ : <mark><%=EventNo %></mark></h4>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12">
                <h4>วันที่ : <mark><%=DateEventStart %></mark></h4>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12">
                <h4>ประเภททรัพย์หลุดจำนำ : <mark><%=GroupName %></mark></h4>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12 text-right" style="margin-bottom: 10px">
                <button type="button" class="btn btn-success " data-toggle="modal" data-target="#myModal" id="addDataBtn"><i class="fa fa-plus-circle" aria-hidden="true"></i>&nbsp;เพิ่มข้อมูล</button>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12" id="dataTable" runat="server">
            </div>
        </div>
        <div id="myModal" class="modal fade" role="dialog" data-keyboard="false" data-backdrop="static">
            <div class="modal-dialog modal-lg ">

                <!-- Modal content-->
                <div class="modal-content">
                    <form class="form-horizontal" id="comittFrm">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                            <h4 class="modal-title">ข้อมูลคณะกรรมการประเมินทรัพย์หลุดจำนำ</h4>
                        </div>

                        <div class=" modal-body">
                            <header class="page-header" style="margin-top: -5px">
                                <h4><i class="fa fa-user-plus" aria-hidden="true"></i>&nbsp;คณะกรรมการควบคุมการจำหน่ายทรัพย์หลุด</h4>
                            </header>
                            <div id="committBlog">
                                <div class="form-group row">
                                    <label class="control-label col-sm-4 col-md-2" for="email">กรรมการคนที่ 1:</label>
                                    <div class="col-sm-8 col-md-10" id="drlBlg0">
                                        <%--<input type="text" class="form-control" id="commit0" placeholder="ประธานกรรมการ">--%>
                                    </div>
                                </div>
                                <div class="form-group row ">
                                    <label class="control-label col-sm-4 col-md-2" for="pwd">พนักงานออกบิล:</label>
                                    <div class="col-sm-8 col-md-10" id="drlBlg1">
                                        <%--<input type="text" class="form-control" id="commit1" placeholder="กรรมการคนที่ 1">--%>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label class="control-label col-sm-4 col-md-2" for="pwd">กรรมการคนที่ 3:</label>
                                    <div class="col-sm-8 col-md-10" id="drlBlg2">
                                        <%--<input type="text" class="form-control" id="commit2" placeholder="กรรมการคนที่ 2">--%>
                                    </div>
                                </div>
                                <div class="form-group row ">
                                    <label class="control-label col-sm-4 col-md-2" for="pwd">กรรมการคนที่ 4:</label>
                                    <div class="col-sm-8 col-md-10" id="drlBlg3">
                                        <%--<input type="text" class="form-control" id="commit1" placeholder="กรรมการคนที่ 1">--%>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-sm-offset-4 col-sm-8  col-md-offset-2 col-md-10">
                                    <a href="#" class="btn btn-success" id="addComitt">
                                        <i class="fa fa-plus-circle" aria-hidden="true"></i>&nbsp;เพิ่มกรรมการ</a>
                                    <a href="#" class="btn btn-danger" id="removeComitt">
                                        <i class="fa fa-minus-circle" aria-hidden="true"></i>&nbsp;ลดกรรมการ</a>
                                </div>
                            </div>
                            <div class="page-header">
                                <h4><i class="fa fa-home" aria-hidden="true"></i>&nbsp;สาขาสถานธนานุบาล</h4>

                            </div>
                            <div id="branchBlg">
                                <div class="form-group row">
                                    <label class="control-label col-sm-4 col-md-2" for="email">สาขาที่ 1:</label>
                                    <div class="col-sm-8 col-md-10" id="brhBlg0">
                                        <%--<input type="text" class="form-control" id="commit0" placeholder="ประธานกรรมการ">--%>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-sm-offset-4 col-sm-8 col-md-offset-2 col-md-10">

                                    <a href="#" class="btn btn-success" id="addBranch">
                                        <i class="fa fa-plus-circle" aria-hidden="true"></i>&nbsp;เพิ่มสาขา</a>
                                    <a href="#" class="btn btn-danger" id="removeBranch">
                                        <i class="fa fa-minus-circle" aria-hidden="true"></i>&nbsp;ลดสาขา</a>

                                </div>
                            </div>
                            <div class="page-header">
                                <h4><i class="fa fa-microphone" aria-hidden="true"></i>&nbsp;โฆษก</h4>

                            </div>
                            <div id="AnnouncerBlg">
                                <div class="form-group row">
                                    <label class="control-label col-sm-4 col-md-2" for="email">โฆษกคนที่ 1:</label>
                                    <div class="col-sm-8  col-md-10" id="announcerBlg0">
                                        <%--<input type="text" class="form-control" id="commit0" placeholder="ประธานกรรมการ">--%>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label class="control-label col-sm-4 col-md-2" for="email">โฆษกคนที่ 2: </label>
                                    <div class="col-sm-8 col-md-10" id="announcerBlg1">
                                        <%--<input type="text" class="form-control" id="commit0" placeholder="ประธานกรรมการ">--%>
                                    </div>
                                </div>
                            </div>
                            <div class="page-header">
                                <h4><i class="fa fa-users" aria-hidden="true"></i></i>&nbsp;เจ้าหน้าที่เสนอทรัพย์หลุดจำนำ</h4>

                            </div>
                            <div id="OfficerBlg">
                                <div class="form-group row">
                                    <label class="control-label col-sm-4 col-md-2" for="email">เจ้าหน้าที่คนที่ 1:</label>
                                    <div class="col-sm-8  col-md-10" id="officerBlg0">
                                        <%--<input type="text" class="form-control" id="commit0" placeholder="ประธานกรรมการ">--%>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label class="control-label col-sm-4 col-md-2" for="email">เจ้าหน้าที่คนที่ 2: </label>
                                    <div class="col-sm-8 col-md-10" id="officerBlg1">
                                        <%--<input type="text" class="form-control" id="commit0" placeholder="ประธานกรรมการ">--%>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="submit" class="btn btn-primary" id="save"><i class="fa fa-floppy-o" aria-hidden="true"></i>&nbsp;บันทึกข้อมูล</button>
                            <button type="submit" class="btn btn-info" id="update"><i class="fa fa-floppy-o" aria-hidden="true"></i>&nbsp;อัพเดทข้อมูล</button>
                            <button type="button" class="btn btn-default" data-dismiss="modal" id="closeBtn"><i class="fa fa-times" aria-hidden="true"></i>&nbsp;Close</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</body>
<script>
    var committNum = 3;
    var branchNum = 0;
    var v_rowId = -1;
    //รับค่าจากหน้าเต้ย
    var v_eventId = <%=eventId %> ;

    $(document).ready(function () {
        LoadDefault(v_eventId);
        //load dropdown สำหรับกรรมการคนที่ 1-3
        for (j = 0; j <= 3; j++) {
            innerDrw(j, "committ", "");
        }
        //Load dropdown สำหรับสาขา
        innerDrw(0, "branch", "");
        //Load dropdown สำหรับโฆษก
        innerDrw(0, "announcer", "");
        innerDrw(1, "announcer", "");
        //Load dropdown สำหรับเจ้าหน้าที่เสนอทรัพย์หลุดจำนำ
        innerDrw(0, "officer", "");
        innerDrw(1, "officer", "");

        $("#GetRow").click(function () {
            alert(getMaxRowNum());
            return false;
        });

        $("#addComitt").click(function () {
            committNum++;
            addCommittRow(committNum);
            $('html, body').animate({ scrollTop: $("#committBlog").offset().top }, 2000);
        });

        $("#removeComitt").click(function () {
            if (committNum > 3) {
                removeCommittRow(committNum)
                committNum--;
            }
            $('html, body').animate({ scrollTop: $("#committBlog").offset().top }, 2000);
        });

        $("#addBranch").click(function () {
            branchNum++;
            addBranchRow(branchNum, "");
            //$('html, body').animate({ scrollTop: $("#branchBlg").offset().top }, 2000);
        });

        $("#removeBranch").click(function () {
            if (branchNum > 0) {
                removeBranchRow(branchNum)
                branchNum--;
            }
        });

        //$("#save").click(function () {
        //    var memberTypeId = 0;
        //    var rownum = getMaxRowNum();
        //    var announcerId = $("#announcer0").val() + "|" +  $("#announcer1").val();
        //    var officialId = $("#officer0").val() + "|" +  $("#officer1").val();
        //    for (i = 0; i <= committNum; i++) {
        //        if (i >= 3) {
        //            memberTypeId = 4;

        //        } else {
        //            memberTypeId = i + 1;
        //        }
        //        for (j = 0 ; j <= branchNum; j++) {
        //            //alert($("#commit" + i).val() + "," + $("#branch" + j).val());
        //            addDataToDB(v_eventId, memberTypeId, $("#commit" + i).val(), $("#branch" + j).val(), rownum , announcerId , officialId);
        //        }
        //    }
        //    alert("บันทึกข้อมูลเรียบร้อย");
        //    LoadDefault(v_eventId);
        //    $('#myModal').modal('hide');
        //    LoadDropdownDefault();
        //    $('html, body').animate({ scrollTop: $("#dataTable").offset().top }, 2000);
        //    return false;
        //});

        $('#update').click(function () {
            //ลบข้อมูลเดิมออก
            var announcerId = $("#announcer0").val() + "|" +  $("#announcer1").val();
            var officialId = $("#officer0").val() + "|" +  $("#officer1").val();
            $.ajax({
                url: "./CommitteeController_ajax.aspx",
                data: "eventId=" + v_eventId + "&rowNum=" + v_rowId + "&type=deleteRow",
                method: "POST",
                success: function (data) {
                    if (data.trim() == "True") {
                        console.log("delsuccess");
                        //alert("ลบข้อมูลเรียบร้อย");
                        //LoadDefault(1);
                    } else {
                        alert("เกิดความผิดพลาด");
                    }
                }
            });
            ////ใส่ข้อมูลใหม่ลงไป
            //var memberTypeId = 0;
            //var rownum = getMaxRowNum();
            //for (i = 0; i <= committNum; i++) {
            //    if (i >= 3) {
            //        memberTypeId = 4;

            //    } else {
            //        memberTypeId = i + 1;
            //    }
            //    for (j = 0 ; j <= branchNum; j++) {
            //        //alert($("#commit" + i).val() + "," + $("#branch" + j).val());
            //        addDataToDB(v_eventId, memberTypeId, $("#commit" + i).val(), $("#branch" + j).val(), rownum,announcerId,officialId);
            //    }
            //}
            //alert("อัพเดทข้อมูลเรียบร้อย");
            //LoadDefault(v_eventId);
            //$('#myModal').modal('hide');
            //LoadDropdownDefault();
            ////$('html, body').animate({ scrollTop: $("#dataTable").offset().top }, 2000);
            //return false;
        });

        $("#closeBtn").click(function () {
            ClearDropDownValue();
            $("#comittFrm").validate().resetForm();
        });
        $("#addDataBtn").click(function () {
            $('#save').show();
            $('#update').hide();
        });

    });

    function ClearDropDownValue(){
        if (committNum > 3) {
            for (i = committNum; i > 3 ; i--) {
                removeCommittRow(i)
                committNum--;
            }
        }
        if (branchNum > 0) {
            for (i = branchNum; i > 0 ; i--) {
                removeBranchRow(i)
                branchNum--;
            }
        }
        $('#commit0').val("").change();
        $('#commit1').val("").change();
        $('#commit2').val("").change();
        $('#commit3').val("").change();
        $('#branch0').val("").change();
        $('#announcer0').val("").change();
        $('#announcer1').val("").change();
        $('#officer0').val("").change();
        $('#officer1').val("").change();
    }

    function LoadDefault(eventId) {
        $.ajax({
            url: "./CommitteeController_ajax.aspx",
            data: "type=loadDefault" + "&eventId=" + eventId,
            method: "POST",
            async: false,
            success: function (data) {
                $("#dataTable").html(data);
            }
        });
    }
    function LoadDropdownDefault() {
        //ชุดข้อมูลพนักงาน
        if (committNum > 3) {
            for (i = committNum; i > 3 ; i--) {
                removeCommittRow(i)
                committNum--;
            }
        }
        for (i = 1; i <= 4 ; i++) {
            //alert(arr[i]);
            if (i <= 4) {
                innerDrw(i - 1, "committ", "");
            } else {
                committNum++;
                addCommittRow(i - 1, "");
            }
        }
        //ชุดข้อมูลสาขา
        if (branchNum > 0) {
            for (i = branchNum; i > 0 ; i--) {
                removeBranchRow(i)
                branchNum--;
            }
        }
        for (i = 1; i <= 1; i++) {
            //alert(arr[i]);
            if (i == 1) {
                innerDrw(i - 1, "branch", "");
            } else {
                branchNum++;
                addBranchRow(i - 1, "");
            }
        }
        //ชุดข้อมูลโฆษก และ เจ้าหน้าที่เสนอทรัพย์หลุดจำนำ
        for (i = 1; i <= 2 ; i++) {
            innerDrw(i - 1, "announcer", "");
            innerDrw(i - 1, "officer", "");
        }
    }

        
    function editRow(rowId, eventId) {
        $('#save').hide();
        $('#update').show();
        $('#myModal').modal('show');
        v_rowId = rowId;
        v_eventId = eventId;
        editRowBranch(rowId, eventId);
        editRowEmp(rowId, eventId);
        editRowAnnouncer(rowId, eventId);
        editRowOfficer(rowId, eventId);
        //$('html, body').animate({ scrollTop: $("#branchBlg").offset().top }, 2000);
    }

    function editRowOfficer(rowId, eventId) {
        var result = "";
        $.ajax({
            url: "./CommitteeController_ajax.aspx",
            data: "eventId=" + eventId + "&rowNum=" + rowId + "&type=editRowOfficer",
            method: "POST",
            async: false,
            success: function (data) {
                result = data;
            }
        });

        var arr = result.split(',');
        for (i = 1; i <= arr.length - 1; i++) {
            //alert(arr[i]);
            //innerDrw(i - 1, "officer", arr[i]);
            $('#officer'+ (i-1)).val(arr[i]).change();
        }
    }

    function editRowAnnouncer(rowId, eventId) {
        var result = "";
        $.ajax({
            url: "./CommitteeController_ajax.aspx",
            data: "eventId=" + eventId + "&rowNum=" + rowId + "&type=editRowAnnouncer",
            method: "POST",
            async: false,
            success: function (data) {
                result = data;
            }
        });

        var arr = result.split(',');
        for (i = 1; i <= arr.length - 1; i++) {
            //alert(arr[i]);
            //innerDrw(i - 1, "announcer", arr[i]);
            $('#announcer'+ (i-1)).val(arr[i]).change();
        }
    }

    function editRowEmp(rowId, eventId) {
        var result = "";
        $.ajax({
            url: "./CommitteeController_ajax.aspx",
            data: "eventId=" + eventId + "&rowNum=" + rowId + "&type=editRowEmp",
            method: "POST",
            async: false,
            success: function (data) {
                result = data;
            }
        });

        var arr = result.split(',');
        if (committNum > 3) {
            for (i = committNum; i > 3 ; i--) {
                removeCommittRow(i)
                committNum--;
            }
        }
        for (i = 1; i <= arr.length - 1; i++) {
            if (i <= 4) {
                innerDrw(i - 1, "committ", arr[i]);
                //$('#commit'+ (i-1)).val(arr[i]).change();
            } else {
                committNum++;
                addCommittRow(i - 1, arr[i]);
            }
        }
    }

    function editRowBranch(rowId, eventId) {
        var result = "";
        $.ajax({
            url: "./CommitteeController_ajax.aspx",
            data: "eventId=" + eventId + "&rowNum=" + rowId + "&type=editRowBranch",
            method: "POST",
            async: false,
            success: function (data) {
                result = data;
            }
        });

        var arr = result.split(',');
        if (branchNum > 0) {
            for (i = branchNum; i > 0 ; i--) {
                removeBranchRow(i)
                branchNum--;
            }
        }
        for (i = 1; i <= arr.length - 1; i++) {
            if (i == 1) {
                innerDrw(i - 1, "branch", arr[i]);
                //$('#branch'+ (i-1)).val(arr[i]).change();
            } else {
                branchNum++;
                addBranchRow(i - 1, arr[i]);
            }
        }
    }


    function deleteRow(rowId, eventId) {
        if (confirm('คุณต้องการลบข้อมูล') == true) {
            $.ajax({
                url: "./CommitteeController_ajax.aspx",
                data: "eventId=" + eventId + "&rowNum=" + rowId + "&type=deleteRow",
                method: "POST",
                success: function (data) {
                    if (data.trim() == "True") {
                        LoadDefault(v_eventId);
                    } else {
                        alert("เกิดความผิดพลาด");
                    }
                }
            });
        }

    }

    //เก็บเพิ่มข้อมูลลง DB
    function addDataToDB(eventId, memberTypeId, userId, branchId, rowNum,announcerId,officerId) {
        $.ajax({
            url: "./CommitteeController_ajax.aspx",
            data: "eventId=" + eventId + "&memberTypeId=" + (memberTypeId+4) + "&userId=" + userId + "&branchId=" + branchId + "&rowNum=" + rowNum + "&announcerId=" + announcerId + "&officerId=" + officerId + "&type=addData",
            method: "POST",
            success: function (data) {
                //alert("บันทึกข้อมูลเรียบร้อยค่ะ");
                //alert(data);
            }
        });
    }
    function getMaxRowNum() {
        var result = "";
        $.ajax({
            url: "./CommitteeController_ajax.aspx",
            data: "type=getRowNum",
            method: "POST",
            async: false,
            success: function (data) {
                result = data;
            }

        });
        return result;
    }

    //สำหรับสร้าง dropdownList
    function innerDrw(num, type, Id) {
        $.ajax({
            url: "./CommitteeController_ajax.aspx",
            data: "num=" + num + "&type=" + type + "&Id=" + Id,
            method: "POST",
            beforeSend: function () {
                if (type == "committ") {
                    $("#drlBlg" + num).html('<i class="fa fa-spinner fa-spin"></i>');
                }else if(type == "announcer"){
                    $('#announcerBlg' + num).html('<i class="fa fa-spinner fa-spin"></i>');
                }else if(type == "officer"){
                    $('#officerBlg' + num).html('<i class="fa fa-spinner fa-spin"></i>');
                }else{
                    $("#brhBlg" + num).html('<i class="fa fa-spinner fa-spin"></i>');
                }
            },
            success: function (data) {
                if (type == "committ") {
                    $("#drlBlg" + num).html(data);
                }else if(type == "announcer"){
                    $('#announcerBlg' + num).html(data);
                }else if(type == "officer"){
                    $('#officerBlg' + num).html(data);
                } else {
                    $("#brhBlg" + num).html(data);
                    //alert(data);
                }
            }
        });
    }
    function addCommittRow(num, empId) {

        var comittCont = "<div class=\"form-group\" id=\"comittNumRow" + num + "\">";
        comittCont += "<label class=\"control-label col-sm-4 col-md-2\" for=\"pwd\">กรรมการคนที่ " + (num+1) + ":</label>";
        comittCont += "<div class=\"col-sm-8 col-md-10\" id=\"drlBlg" + num + "\">";
        comittCont += "</div>";
        comittCont += "</div>";

        $("#committBlog").append(comittCont);

        innerDrw(num, "committ", empId)
    }
    function removeCommittRow(num) {
        var element = "#comittNumRow" + num;
        $("" + element + "").remove();

    }

    function addBranchRow(num, branchId) {

        var comittCont = "<div class=\"form-group\" id=\"branchNumRow" + num + "\">";
        comittCont += "<label class=\"control-label col-sm-4 col-md-2\" for=\"pwd\">สาขาที่ " + (num + 1) + ":</label>";
        comittCont += "<div class=\"col-sm-8 col-md-10\" id=\"brhBlg" + num + "\">";
        comittCont += "</div>";
        comittCont += "</div>";

        $("#branchBlg").append(comittCont);
        innerDrw(num, "branch", branchId);
    }
    function removeBranchRow(num) {
        var element = "#branchNumRow" + num;
        $("" + element + "").remove();
    }
    //////
</script>
</html>
