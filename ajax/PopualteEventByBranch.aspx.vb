Imports System.Data
Imports Newtonsoft.Json
Imports System.IO
Imports System.Collections.Generic
Imports PSCS.Libary.Models
Partial Class ajax_PopualteEventByBranch
    Inherits System.Web.UI.Page

    Private Sub ajax_PopualteEventByBranch_Load(sender As Object, e As EventArgs) Handles Me.Load
        Dim tokenOb As New PSCS.Libary.Models.TokenClass
        'Dim tokenID As String = CStr(tokenOb.TokenId)
        Dim BranchId As Integer = CType(Session(WebConstant.SessionName_UserObj), TokenClass).BranchId
        Dim Emid As String = CType(Session(WebConstant.SessionName_UserObj), TokenClass).PrivateCode
        Dim RoleID As String = CType(Session(WebConstant.SessionName_UserObj), TokenClass).RoleId


        'Dim branchId As String = Request.Form("branchId")

        Dim dt As New DataTable
        dt = DataConnection.DataAccessClassAsset.getEventToDropDownByBranch(Integer.Parse(BranchId))
        Dim json = JsonConvert.SerializeObject(dt, Formatting.Indented)
        Response.Write(json)
    End Sub
End Class
