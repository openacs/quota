--
-- Copyright (C) 2004 University of Valencia
--
--  This file is part of dotLRN.
--
--  dotLRN is free software; you can redistribute it and/or modify it under the
--  terms of the GNU General Public License as published by the Free Software
--  Foundation; either version 2 of the License, or (at your option) any later
--  version.
--
--  dotLRN is distributed in the hope that it will be useful, but WITHOUT ANY
--  WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
--  FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
--  details.
--
--
--   QUOTA DROP TABLES
--
--   @author Paco Soler (fransola@uv.es)
--   @author Agustin Lopez (Agustin.Lopez@uv.es)
--   @creation-date 2005-12-15
--   @version $Id: quota-portlet-drop.sql,v 0.2 2005-12-15


--Drop data
drop sequence user_quota_sequence;
drop index user_quota_idx;
drop table user_quota;


