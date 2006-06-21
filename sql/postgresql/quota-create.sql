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
--   QUOTA TABLES CREATE
--
--   @author Paco Soler (fransola@uv.es)
--   @author Agustin Lopez (Agustin.Lopez@uv.es)
--   @creation-date 2005-12-15
--   @version $Id: quota-portlet-drop.sql,v 0.2 2005-12-15


-- TABLES  -------------------------------------------------------------

-- TABLE USER_QUOTA -------------------------------------------------------------
create sequence user_quota_sequence start 1;
create table user_quota (
        quota_id        integer primary key default nextval('user_quota_sequence'),
        ref_user        integer not null,        
        global_quota    integer not null,        
        global_files    integer not null,        
        personal_quota  integer not null,        
        personal_files  integer not null,
        usercomm_actv   boolean default true,        
        constraint      ref_user_id_fk foreign key (ref_user) references users (user_id)
);
create index user_quota_idx on user_quota (ref_user);

