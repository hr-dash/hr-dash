$ ->
  $('.prev_month').click ->
    target_month = $(this).data('target-month')

    $.ajax({
      url: "/monthly_reports/prev_month?target_month=#{target_month}",
      success: (data) ->
        console.log(data.tags)
        $('#monthly_report_project_summary').html(data.monthly_report.project_summary)
        $('#monthly_report_business_content').html(data.monthly_report.business_content)
        $('#monthly_report_looking_back').html(data.monthly_report.looking_back)
        $('#monthly_report_next_month_goals').html(data.monthly_report.next_month_goals)
   })
