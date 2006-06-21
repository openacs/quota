<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

<fullquery name="quota::get_quota_package_id.get_quota_package_id">
    <querytext>
                select object_id as pid from acs_objects, apm_packages as apmp
                where context_id = 
                        (select package_id from dotlrn_communities_all 
                        where community_id = :community_id)
                and package_key = 'quota' 
                and object_id = apmp.package_id;
        </querytext>
</fullquery>

<fullquery name="quota::get_community_parameter.get_community_parameter">
    <querytext>
                select attr_value as value from apm_parameter_values 
                where parameter_id = :param_id and
                      package_id = :pid
        </querytext>
</fullquery>



<fullquery name="quota::update_parameter.update_parameter">
    <querytext>
                update apm_parameters set 
                default_value = :value
                where parameter_name = :param
        </querytext>
</fullquery>    


<fullquery name="quota::update_community_parameter.update_community_parameter">
    <querytext>
                update apm_parameter_values 
                set attr_value = :value
                where parameter_id = :param_id and
                      package_id = :pid
        </querytext>
</fullquery>    

<fullquery name="quota::check_quota.get_quota">
    <querytext>
                select * from user_quota 
                where ref_user = :user_id
                      
        </querytext>
</fullquery>    


<fullquery name="quota::get_used_quota_and_files.get_user_qf">
    <querytext>
                select content_length from cr_revisions, acs_objects 
                where   revision_id = object_id and 
                                object_type = 'file_storage_object' and 
                                content_length > 0 and
                                (creation_user = :user_id or modifying_user = :user_id);
        </querytext>
</fullquery>    


        
<fullquery name="quota::get_child_folders.get_child_folders">
        <querytext>
                select folder_id 
                from fs_folders 
                where parent_id = :folder_id            
        </querytext>
</fullquery>    


        <fullquery name="quota::get_folder_files.get_folder_files">
        <querytext>
                        select item_id 
                        from cr_items 
                        where parent_id = :folder_id and 
                              content_type::text = :type_s::text
        </querytext>
    </fullquery>                
        
    <fullquery name="quota::get_revision_files.get_revision_files">
        <querytext>
                        select revision_id
                        from cr_revisions
                        where item_id = :item_id
        </querytext>
    </fullquery>                        

        <fullquery name="quota::get_filesize.get_filesize">
        <querytext>
                        select content_length as size
                        from cr_revisions 
                        where revision_id = :revision_id
        </querytext>
    </fullquery>        

        <fullquery name="quota::get_user_communities.get_user_communities">
        <querytext>
                        select community_id from dotlrn_member_rels_approved where user_id = :user_id   
        </querytext>
    </fullquery>                
        
    <fullquery name="quota::get_folder_user_revisions.get_folder_user_revisions">
        <querytext>
                        select revision_id from cr_revisions where item_id in (select item_id from acs_objects, cr_items where object_type = 'content_item' and content_type = 'file_storage_object' and parent_id = :folder_id and object_id = item_id and (creation_user = :user_id or modifying_user = :user_id));
        </querytext>
    </fullquery>                
        
</queryset>
