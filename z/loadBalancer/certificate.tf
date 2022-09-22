# resource "aws_acm_certificate" "terralabs" {
#   domain_name       = "aws-terralabs.tk"
#   validation_method = "DNS"
# }

# data "aws_route53_zone" "terralabs" {
#   name         = "aws-terralabs.tk"
#   private_zone = false
# }

# resource "aws_route53_record" "terralabs" {
#   for_each = {
#     for dvo in aws_acm_certificate.terralabs.domain_validation_options : dvo.domain_name => {
#       name   = dvo.resource_record_name
#       record = dvo.resource_record_value
#       type   = dvo.resource_record_type
#     }
#   }

#   allow_overwrite = true
#   name            = each.value.name
#   records         = [each.value.record]
#   ttl             = 60
#   type            = each.value.type
#   zone_id         = data.aws_route53_zone.terralabs.zone_id
# }

# resource "aws_acm_certificate_validation" "terralabs" {
#   certificate_arn         = aws_acm_certificate.terralabs.arn
#   validation_record_fqdns = [for record in aws_route53_record.terralabs : record.fqdn]
# }

# # resource "aws_lb_listener" "terralabs" {
# #   # ... other configuration ...

# #   certificate_arn = aws_acm_certificate_validation.terralabs.certificate_arn
# # }
