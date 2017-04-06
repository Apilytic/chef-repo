#
# Cookbook Name:: sklad1
# Recipe:: user
#
# Copyright (c) 2017 The Authors, All Rights Reserved.


ssh_authorize_key 'chichi@sklad1' do
  key 'AAAAB3NzaC1yc2EAAAADAQABAAABAQDMG+HRcOHKOS/bVaHQ151A3rhN3TLvnL7czspd/Q34eeo+hpbxSY+/hQnBJ0pLlKG2v8VGySky2YBfa8tQkJFjAFGe4nBfHaaJ2oa09e8aIyfpKnqsaisZ/T7f5WLs0GqBgawlWePAYPlh7nt6iKw5TascdIVuwn9nHmZgFrOMH/JoudnIohOFMRRANUk6GeBF+mSSCqdVvrCdOG93P/Uo5nFSy6KBgq+87+MxotEAWimRObkqncsMma9n9D19/WeDihFdFOptNKC0j+JsP95uu4YkaSs+9TH3Dp+y5uL7RZSZouXJfjuDd6z9VMabzO5AbS9rmrRa/q6E5Le3mGy7'
  user 'root'
end

ssh_authorize_key 'g@sklad1' do
  key 'AAAAB3NzaC1yc2EAAAADAQABAAABAQDG3GvfERiSM9LLmvvrja7XGkU6FIi48vbNEOg3MmuRAXEIZebm+YJ30h0ZLk/RWtbUmDtrZp7dYYfsjvKBeRiHtCGjyTf18KRwiq5SlwTdRI21i4TtB3Ydjl4KUF5ZRQVjfX0jlvJ2Va2cDUQISg29HMrnRzqM4c3T/96CNnVwkI93CxBMjCVJWOcoH3+T6XUv8O50W4IpxoWZzSgyEO8/8/Z2GcCOrKrZ5cY/I7KH9kqJQY+BrwdZixM85z8M7VFfXoE/2AmWxcLGYi6j2kTr7ml8nAjXcp/pGxd1L7IdHTzeUTUgyHIM1T2tK3JdkloqFWjyWfygG3wgX61Lr3yh'
  user 'root'
end