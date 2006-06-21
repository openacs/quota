<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>
        
        <fullquery name="get_community_info">
                <querytext>
                        select community_id, pretty_name, community_key 
                        from dotlrn_communities_all
                        where community_id = :cid
            </querytext>
    </fullquery>        
        
                
</queryset>
