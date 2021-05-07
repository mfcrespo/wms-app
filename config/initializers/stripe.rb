# Copyright (c) 2021 Maria Crespo
# Don't count the days, make the days count...Go Head!
# All Rights Reserved

Rails.configuration.stripe = {
:publishable_key => 'pk_test_51InyPsJmKOk3DcBpOCmygd5ejlBeJ93YefEAkj6HwKH3Ooqq8YmQowLZZeEZ9VYZQzC61LujvOJMzJYPD5qyd87u005skVA1XD',
:secret_key => 'sk_test_51InyPsJmKOk3DcBpr84SQMcjVaPKIVlSk1CM09OBcLaDEWJtDFdJRWiqmlss3OPbkUBSR14s8D8uHhMQ4Y2gYXOq00RC9TugWQ'
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]