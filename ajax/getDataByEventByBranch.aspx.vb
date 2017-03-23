Imports System.Data
Imports System.Web.UI
Imports PSCS.Libary.Models
Imports DataConnection.DataAccessClassAsset
Imports Newtonsoft.Json
Imports System.IO
Partial Class ajax_getDataByEventByBranch
    Inherits System.Web.UI.Page

    Private Sub ajax_getDataByEventByBranch_Load(sender As Object, e As EventArgs) Handles Me.Load
        Dim tokenOb As New PSCS.Libary.Models.TokenClass
        If Not PawnUtilFn.GetSessionUserObj(tokenOb) Then
            Response.Redirect("../../../login.aspx")
            Exit Sub
        End If

        Dim RoleId As Integer = tokenOb.RoleId

        Dim BranchId As Integer = tokenOb.BranchId

        Dim json As String
        Using reader = New StreamReader(Request.InputStream)
            json = reader.ReadToEnd()
        End Using

        Dim data As eventid = JsonConvert.DeserializeObject(Of eventid)(json)

        Dim eventid As String = data.eventid

        Dim dt As New DataTable

        dt = DataConnection.DataAccessClassAsset.getAssetFallByEvent(BranchId, RoleId, eventid)
        Dim jsonsTr = JsonConvert.SerializeObject(dt, Formatting.Indented)
        Response.Write(jsonsTr)
    End Sub

End Class
