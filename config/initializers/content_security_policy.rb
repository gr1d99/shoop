# Rails.application.config.content_security_policy do |policy|
#   policy.default_src :self, :https
#   policy.font_src :self, :https
#   policy.img_src :self, :https, :data, '*.com'
#   policy.object_src :none
#   policy.script_src :self, :unsafe_inline, '*.', 'player.vimeo.com', '*.cloudflare.com'
#   policy.style_src :self, :https, :unsafe_inline, :unsafe_eval
#   policy.frame_src :self, '*.youtube.com', '*.vimeo.com'
#
#   # Specify URI for violation reports
#   # policy.report_uri "/csp-violation-report-endpoint"
# end