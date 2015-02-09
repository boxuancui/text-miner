$(document).ready(function () {
	$("input[name='data_source']").change(function () {
		if ($("#data_source2").prop("checked")) {
			$("#upload_data").show();
		} else {
			$("#upload_data").hide();
		}
	})
});
