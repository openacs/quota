<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>
        
        <fullquery name="select_users">
                <querytext>
                        select user_id, first_names, last_name, username 
                        from acs_users_all
                        where last_name like '$name%'
                        order by last_name asc
            </querytext>
    </fullquery>        
 
 
        <fullquery name="select_usernames">
                <querytext>
                        select user_id, first_names, last_name, username 
                        from acs_users_all
                        where username like '$username%'
                        order by last_name asc
            </querytext>
    </fullquery>                
                
</queryset>
