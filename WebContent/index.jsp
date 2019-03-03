<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>ChartJS Example</title>
<script src="js/Chart.bundle.min.js"></script>
<script>
var chartColor = [
		'rgb(255, 99, 132)', //red
		'rgb(255, 159, 64)', //orange
		'rgb(255, 205, 86)', //yellow
		'rgb(75, 192, 192)', //green
		'rgb(54, 162, 235)', //blue
		'rgb(153, 102, 255)', //purple
		'rgb(201, 203, 207)' //grey
	];
</script>
<style>
table ,tr, td,th {
  border:1px solid black;
};
</style>
</head>
<body>
<table>
    <tr>
        <th>Property</th>
        <th>Coastline</th>
        <th>Life Expectancy</th>
        <th>Elevation</th>
        <th>Population</th>
        <th>Age</th>
    </tr>
    <tr>
        <th>France</th>
        <td>4853</td>
        <td>81.8</td>
        <td>375</td>
        <td>66836154</td>
        <td>41.2</td>
    </tr>
    <tr>
        <th>Germany</th>
        <td>2389</td>
        <td>80.7</td>
        <td>263</td>
        <td>80722792</td>
        <td>46.8</td>
    </tr>
    <tr>
        <th>Italy</th>
        <td>7600</td>
        <td>82.2</td>
        <td>538</td>
        <td>62007540</td>
        <td>45.1</td>
    </tr>
    <tr>
        <th>UK</th>
        <td>12429</td>
        <td>80.7</td>
        <td>162</td>
        <td>64430428</td>
        <td>40.5</td>
    </tr>
</table>

<br/><br/>
<input type="button" id="showHidebutton1" value="Show Coastline Chart" onclick="showHideChart(this)">
<input type="button" id="showHidebutton2" value="Show Life Expectancy Chart" onclick="showHideChart(this)">
<input type="button" id="showHidebutton3" value="Show Elevation Chart" onclick="showHideChart(this)">
<input type="button" id="showHidebutton4" value="Show Population Chart" onclick="showHideChart(this)">
<input type="button" id="showHidebutton5" value="Show Age Chart" onclick="showHideChart(this)">

<div id="chartDiv" style="display: none;">
</div>
</body>
<script>
function showHideChart(btn) {
	if(btn.value.includes("Show")) {
		document.getElementById('chartDiv').style.display = 'block';
		var table = document.querySelector('table');
		var tableArr = [];
		var tableLab = [];
		var tableTime = [];
		
		//loop all rows and form data array
		for ( var i = 1; i <= table.rows.length; i++ ) {
		    tableArr.push([
		     table.rows[1].cells[i].innerHTML,
		     table.rows[2].cells[i].innerHTML,
		     table.rows[3].cells[i].innerHTML,
		     table.rows[4].cells[i].innerHTML
		    ]);
		    tableLab.push(table.rows[0].cells[i].innerHTML);
		    if(i<table.rows.length)
		    	tableTime.push(table.rows[i].cells[0].innerHTML);
		    var canvas = document.createElement("canvas");
		    canvas.setAttribute("id", "myChart"+i);
		    canvas.setAttribute("height", "480px!important");
		    canvas.setAttribute("width", "640px!important");
		    document.getElementById('chartDiv').appendChild(canvas);
		}
		console.log(tableArr);
		console.log(tableLab);
		//loop array of data and create chart for each row
		tableArr.forEach(function(e,i){
		  var chartID = "myChart"+ (i+1)
		  var ctx = document.getElementById(chartID).getContext('2d');
		  var myChart = new Chart(ctx, {
		    type: 'line',
		    data: {
		        labels: tableTime,
		        datasets: [{
		            label: tableLab[i],
		            data: e,
		            fill: false,
		            backgroundColor: chartColor[i],
		            borderColor: chartColor[i],
		        }]
		    },
		    options: {
		    	responsive: false,
		    	tooltips: {
					mode: 'index',
					intersect: false,
				},
				hover: {
					mode: 'nearest',
					intersect: true
				},
		    	maintainAspectRatio: false,
		        scales: {
		        	xAxes: [{
						display: true,
						scaleLabel: {
							display: true,
							labelString: 'Day/Time'
						}
					}],
		            yAxes: [{
		            	display: true,
		            	scaleLabel: {
							display: true,
							labelString: 'Value'
						}/* ,
		                ticks: {
		                    beginAtZero:true
		                } */
		            }]
		        }
		    }
		});
		  if(!btn.id.includes(''+(i+1)))
			  document.getElementById(chartID).style.display ="none";
		});
		btn.value = btn.value.replace("Show","Hide");
		for(var j = 1; j <=5; j++) {
			if(!btn.id.includes(j))
				document.getElementById("showHidebutton"+j).disabled = true;
		}
	}
	else if(btn.value.includes("Hide")) {
		var chartDiv = document.getElementById('chartDiv');
		chartDiv.style.display = 'none';
		while(chartDiv.firstChild) {
			chartDiv.removeChild(chartDiv.firstChild);
		}
		btn.value = btn.value.replace("Hide","Show");
		for(var j = 1; j <=5; j++) {
			if(!btn.id.includes(j))
				document.getElementById("showHidebutton"+j).disabled = false;
		}
	}
}
</script>
</html>