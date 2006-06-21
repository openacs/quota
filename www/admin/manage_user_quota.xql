<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>
        
        <fullquery name="get_user_info">
                <querytext>
                        select user_id, first_names, last_name, username 
                        from acs_users_all
                        where user_id = :uid
            </querytext>
    </fullquery>        
        
        <fullquery name="get_user_quota">
                <querytext>
                        select * from user_quota  
                        where ref_user = :uid
            </querytext>
    </fullquery>                
        
        <fullquery name="update_user_quota_actv">
                <querytext>
                        update user_quota  
                        set usercomm_actv = :value
                        where quota_id = :quota_id
            </querytext>
    </fullquery>                
        
        <fullquery name="update_user_quota">
                <querytext>
                        update user_quota  
                        set global_quota = :new_global_quota,
                                global_files = :new_global_files,
                                personal_quota = :new_personal_quota,
                                personal_files = :new_personal_files                    
                        where quota_id = :quota_id
            </querytext>
    </fullquery>
        
        <fullquery name="insert_user_quota">
                <querytext>
                        insert into user_quota (ref_user, global_quota, global_files,
                                personal_quota, personal_files, usercomm_actv)
                        values (:uid, :new_global_quota, :new_global_files, 
                                :new_personal_quota, :new_personal_files, true)
            </querytext>
    </fullquery>        

        <fullquery name="delete_user_quota">
                <querytext>
                        delete from user_quota 
                        where   quota_id = :quota_id and
                                        ref_user = :uid
            </querytext>
    </fullquery>                
                
</queryset>
