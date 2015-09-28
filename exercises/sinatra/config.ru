$LOAD_PATH.unshift(__dir__ + '/lib')

require 'bill_app'
require 'bill_service_app'

use BillServiceApp
run BillApp

