Imports System.Data
Imports System.Web.UI
Imports PSCS.Libary.Models
Imports DataConnection.DataAccessClassAsset
Imports Newtonsoft.Json
Partial Class ajax_LoadBranchByEvent
    Inherits System.Web.UI.Page

    Private Sub ajax_LoadBranchByEvent_Load(sender As Object, e As EventArgs) Handles Me.Load
        Dim tokenOb As New PSCS.Libary.Models.TokenClass
        'Dim tokenID As String = CStr(tokenOb.TokenId)
        Dim BranchId As Integer = CType(Session(WebConstant.SessionName_UserObj), TokenClass).BranchId
        Dim Emid As String = CType(Session(WebConstant.SessionName_UserObj), TokenClass).PrivateCode
        Dim RoleID As String = CType(Session(WebConstant.SessionName_UserObj), TokenClass).RoleId


        'Dim branchId As String = Request.Form("branchId")

        Dim eventid As String = Request.Form("eventid")



        Dim dt As New DataTable
        dt = DataConnection.DataAccessClassAsset.getBranchByEvent(eventid)

        Dim json = JsonConvert.SerializeObject(dt, Formatting.Indented)
        Response.Write(json)
    End Sub
End Class
