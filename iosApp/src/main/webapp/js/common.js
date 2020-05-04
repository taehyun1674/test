$(document).ready(function(){
	$(function(){
		var windowHeight = $( window ).height();
		var itemHeight = $(".contentContainer").outerHeight(true);
		if (windowHeight > itemHeight) {
			$(".pageWrap").addClass("menuFixed");
		}	else	{
			$(".pageWrap").removeClass("menuFixed");
		}
	});
	$(window).resize(function (){
		var windowHeight = $( window ).height();
		var itemHeight = $(".contentContainer").outerHeight(true);
		if (windowHeight > itemHeight) {
			$(".pageWrap").addClass("menuFixed");
		}	else	{
			$(".pageWrap").removeClass("menuFixed");
		}
	});

	$(document).on('click', '.popupBtn', function() {
		var popupIndex = $(this).attr('id');
		$(".popupContainer."+popupIndex).show();
		var popupHeight = $('.popupContainer .popupWrap').not( ":hidden" ).height();
		$('.popupContainer .popupWrap').not( ":hidden" ).css("top","calc(50% - "+(popupHeight+2)/2+"px");


	});

/*
	$(document).on('click', '.popupDimmed', function() {
		$(this).parent().hide();
	});
	$(document).on('click', '.popupContainer .close', function() {
		$('.popupContainer').hide();
	});
*/
	$(document).on('click', '.tabBtn li', function() {
		var tabIndex = $(this).attr('id');
		$(this).siblings().removeClass("on");
		$(this).addClass("on");
		$(".tableWrap").hide();
		$(".tableWrap."+tabIndex).show();
	});
	
	$(document).on('click', '.menuBtn li', function() {
		$(this).siblings().removeClass("on");
		$(this).addClass("on");
	});
	
	$(document).on('click', '#periodType li', function() {
		$(this).siblings().removeClass("on");
		$(this).addClass("on");
	});
	
	$(document).on('click', '#INTERNET_PERIOD li', function() {
		$(this).siblings().removeClass("on");
		$(this).addClass("on");
	});
	
	$(document).on('click', '#WEB_PERIOD li', function() {
		$(this).siblings().removeClass("on");
		$(this).addClass("on");
	});
	
	$(document).on('click', '#LOCAL_PERIOD li', function() {
		$(this).siblings().removeClass("on");
		$(this).addClass("on");
	});

	$(document).on('click', '.tableViewBtn', function() {
		$(".tableWrap").hide();
		$(".tableWrap.speed_table").show();
	});
	$(document).on('click', '.mapViewBtn', function() {
		$(".tableWrap").hide();
		$(".tableWrap.table_speed").show();
	});

});
var StringBuffer = {};
(function() {	
	StringBuffer = function(){
		this.buffer = new Array();
	}
	
	StringBuffer.prototype.append = function(str) {
	    this.buffer[this.buffer.length] = str;
	};

	StringBuffer.prototype.toString = function() {
	    return this.buffer.join("");
	};	

	StringBuffer.prototype.empty = function(){
		return this.buffer.length = 0;
	}
})();

var common = {
		ajax : function(SendUrl, params, type, callback){
			$.ajax({
				type : 'POST',
				url  : SendUrl,
				data : params,
				dataType : type,
				beforeSend : function(){
				},
				complete : function(){
				},
				success  : callback,
				error	 : function(request, status, error) {
					console.log();
				}
		});
	}
}


var GetObject = {
		id : function(IdStr){
			return document.getElementById(IdStr);
		},		
		trim : function(obj){
			if(obj != null){
				return obj.value.trim();
			}
			return "";
		},
		length : function(obj){
			return obj.value.length;
		},
		name : function(NameStr){
			return document.getElementsByName(NameStr);
		},
		focus : function(IdStr){
			var Obj = GetObject.id(IdStr);
			if(Obj != null){
				Obj.focus();
			}
		},
		radioValue : function(NameStr){
			var TargetObj = GetObject.name(NameStr);
			var RadioValue = "";
			
			try{
				if(TargetObj != null){
					for(var idx = 0; idx < TargetObj.length; idx++){
						if(TargetObj[idx].checked){
							RadioValue = TargetObj[idx].value;
							break;
						}
					}
				}
			}catch(e){
				RadioValue = "";
			}
			
			return RadioValue;
		}
	};
