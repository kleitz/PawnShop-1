Imports System.Data
Imports System.Web.UI
Imports PSCS.Libary.Models
Imports DataConnection.DataAccessClassAsset
Imports Newtonsoft.Json
Imports System.IO
Partial Class ajax_UpdateTrayDetail
    Inherits System.Web.UI.Page

    Private Sub ajax_UpdateTrayDetail_Load(sender As Object, e As EventArgs) Handles Me.Load
        Dim tokenOb As New PSCS.Libary.Models.TokenClass
        Dim tokenID As String = CStr(tokenOb.TokenId)
        Dim BranchId As Integer = CType(Session(WebConstant.SessionName_UserObj), TokenClass).BranchId

        Dim RoleID As String = CType(Session(WebConstant.SessionName_UserObj), TokenClass).RoleId

        Dim Username As String = CType(Session(WebConstant.SessionName_UserObj), TokenClass).UserName

        Dim json As String
        Using reader = New StreamReader(Request.InputStream)
            json = reader.ReadToEnd()
        End Using

        Dim data As SetTrayEdit = JsonConvert.DeserializeObject(Of SetTrayEdit)(json)
        Dim trayid As String = data.TrayID
        Dim Category As Integer = data.Category
        Dim Amount As Decimal = data.Amount
        Dim Estimate As Decimal = data.Estimate

        Try
            UpdateTrayDetail(Category, Amount, Estimate, trayid)
            Response.Write("Success")
        Catch ex As Exception
            Response.Write("fail")
        End Try

    End Sub
End Class
