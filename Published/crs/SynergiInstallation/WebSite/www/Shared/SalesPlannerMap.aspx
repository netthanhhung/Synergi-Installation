<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SalesPlannerMap.aspx.cs" Inherits="Planet.Rockford.TimeClock.Web.UI.SalesPlannerMap" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
      #container{
        position:relative;
        height:700px;
      }
      #directions{
        position:absolute;
        width: 23%;
        right:1%;
        height: 300px;
        overflow:auto;
      }
      #googleMap{
        border: 1px dashed #C0C0C0;
        width: 75%;
        height: 700px;
      }
      #menu{
        background-color: #FFFFFF;
        width:170px;
        height:150px;
        padding:0px;
        border:1px;
        cursor:pointer;
        border-left:1px solid #cccccc;
        border-top:1px solid #cccccc;
        border-right:1px solid #676767;
        border-bottom:1px solid #676767;
      }
      #menu .item{
        font-family: arial,helvetica,sans-serif;
        font-size: 12px;
        text-align:left;
        line-height: 30px;
        border-left:0px;
        border-top:0px;
        border-right:0px;
        padding-left:30px;
        background-repeat: no-repeat;
        background-position: 4px center;
      }
      #menu .item.startLocation{
        background-image: url(../Images/GoogleMapMarker/startLocationIcon.png);
      }
      #menu .item.stopLocation{
        background-image: url(../Images/GoogleMapMarker/endLocationIcon.png);
      }
      #menu .item.Find5Km{
        background-image: url(../Images/GoogleMapMarker/lookupIcon.png);
      }
      #menu .item.Find10Km{
        background-image: url(../Images/GoogleMapMarker/lookupIcon.png);
      }
      #menu .item.Find20Km{
        background-image: url(../Images/GoogleMapMarker/lookupIcon.png);
      }
      #menu .item.separator{
        border-bottom:1px solid #cccccc;
      }
    </style>
    <%-- REMEMBER TO FIX THESE LINK IN CASE OF CHANGING PAGE LOCATION --%>
    <script src="http://maps.google.com/maps/api/js?sensor=false" type="text/javascript"></script>
    <script src="http://maps.google.com/maps/api/js?sensor=false&v=3&libraries=geometry" type="text/javascript"></script>
    <script src="../Scripts/jquery.min.js" type="text/javascript"></script>
    <script src="../Scripts/jquery-ui.min.js" type="text/javascript"></script>
    <link href="../Scripts/jquery-ui.css" rel="stylesheet" type="text/css"/>
    <script src="../Scripts/jquery.json-2.2.min.js" type="text/javascript"></script>
    <script src="../Scripts/gmap3.js" type="text/javascript"></script>
    <script src="../Scripts/SalesPlanner.js" type="text/javascript"></script>
</head>
<body onload="initialize()" style="width:100%;height:100%;background-color:White">
      <div id="directions" style="visibility:collapse"></div>
      <div id="map_canvas" style="width: 500px; height: 300px;"></div>
      <div id="progressbar" style="height:20px"></div>
</body>
</html>
