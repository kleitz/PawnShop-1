Imports System.Data
Imports Newtonsoft.Json
Imports System.IO
Imports System.Collections.Generic
Partial Class ajax_PopualteEventByBranch
    Inherits System.Web.UI.Page

    Private Sub ajax_PopualteEventByBranch_Load(sender As Object, e As EventArgs) Handles Me.Load

        Dim branchId As String = Request.Form("branchId")

        Dim dt As New DataTable
        dt = DataConnection.DataAccessClassAsset.getEventToDropDownByBranch(Integer.Parse(branchId))
        Dim json = JsonConvert.SerializeObject(dt, Formatting.Indented)
        Response.Write(json)
    End Sub
End Class
