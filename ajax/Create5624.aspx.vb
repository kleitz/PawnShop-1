Imports System.Data
Imports System.Web.UI
Imports PSCS.Libary.Models
Imports DataConnection.DataAccessClassAsset
Imports Newtonsoft.Json
Partial Class ajax_Create5624
    Inherits System.Web.UI.Page

    Private Sub ajax_Create5624_Load(sender As Object, e As EventArgs) Handles Me.Load
        Dim para(3) As String
        para(0) = Request.QueryString("branch")
        para(1) = Request.QueryString("period")
        para(2) = Request.QueryString("month")
        para(3) = Request.QueryString("year")

        Dim spara As Integer = para.Length

        'Response.Write(spara & ":" & para(0) & ":" & para(1))
        CrytalBuild.CreateReport("5624.rpt", para, spara)
    End Sub
End Class
