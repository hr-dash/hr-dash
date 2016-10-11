$ ->
  $('#new_inquiry').on 'ajax:error', (e, xhr, status, error) ->
    alert 'エラーが発生しました。お手数ですが、しばらく待つか直接メールにてお問い合わせください'
    $('#inquiry-error').hide();
    $('#inquiry_body').val('');
    $('#new_inquiry').modal('hide');
