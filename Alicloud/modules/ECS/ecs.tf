provider "alicloud" {
  access_key = "xxxx"
  secret_key = "xxx"
  region     = "cn-shanghai"
}

resource "alicloud_security_group" "group" {
  name        = "terraform-test-group"
  description = "New security group"
  vpc_id      = "${alicloud_vpc.vpc.id}"
}

resource "alicloud_vpc" "vpc" {
  name       = "tf_test_foo"
  cidr_block = "172.16.0.0/12"
}

resource "alicloud_vswitch" "vsw" {
  vpc_id            = "${alicloud_vpc.vpc.id}"
  cidr_block        = "172.16.0.0/21"
  availability_zone = "cn-shanghai-f"
}

resource "alicloud_instance" "instance" {
  # cn-beijing
  availability_zone = "cn-shanghai-f" #区域

  # series III
  instance_name              = "test_foo"                                #实例名字
  instance_type              = "ecs.g5.large"                            #启动实例类型
  description                = "test"                                    #实例描述
  image_id                   = "centos_7_06_64_20G_alibase_20190218.vhd" #系统类型
  vswitch_id                 = "${alicloud_vswitch.vsw.id}"              #要在VPC中启动的虚拟交换机ID
  security_groups            = ["${alicloud_security_group.group.id}"]   #安全组ID
  system_disk_category       = "cloud_efficiency"                        #磁盘类型cloud：普通云盘  cloud_efficiency：高效云盘   cloud_ssd：SSD 云盘
  system_disk_size           = "40"                                      #系统磁盘的大小
  internet_charge_type       = "PayByTraffic"                            #实例的Internet费用类型 有效值为PayByBandwidth(预付费)，PayByTraffic(按量)
  internet_max_bandwidth_in  = 200                                       #来自公共网络的最大传入带宽
  internet_max_bandwidth_out = 0                                         #公共网络的最大传出带宽
  host_name                  = "test-foo"                                #主机名称
  password                   = "P@ssw0rd"                                #主机登陆密码

  #period_unit                = "Hourly"                                  #购买资源的持续时间单位
  period  = 1       #购买资源的持续时间
  dry_run = "false"

  data_disks {
    #创建的数据磁盘列表
    name                 = "test01"           #数据磁盘的名称
    size                 = "20"
    category             = "cloud_efficiency" #磁盘类别
    encrypted            = "false"            #加密此磁盘中的数据
    delete_with_instance = "true"             #销毁实例时删除此数据磁盘
    description          = " test"            #数据磁盘的描述
  }
}

resource "alicloud_security_group_rule" "allow_all_tcp" {
  type              = "ingress"
  ip_protocol       = "tcp"
  nic_type          = "intranet"
  policy            = "accept"
  port_range        = "1/65535"
  priority          = 1
  security_group_id = "${alicloud_security_group.group.id}"
  cidr_ip           = "0.0.0.0/0"
}
