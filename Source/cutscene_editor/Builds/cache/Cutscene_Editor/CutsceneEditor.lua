LuaR  �

         7    @ A@  @  @ A�  @  @ A�  @  @ A  @  @ A@ @  @ A� @  @ A� @  @ A  @  @ A@ @  @ A� @  @ A� � D   �   ����@  � ���  �����  � ��  ����@ � ��� ����� � ��  ����@ � � �       require    FCM_Utilities.lua    FCM_AgentExtensions.lua    FCM_Color.lua    FCM_Printing.lua    FCM_PropertyKeys.lua    FCM_Development_Freecam.lua !   FCM_Development_AgentBrowser.lua    FCM_DepthOfFieldAutofocus.lua    FCM_Scene_PrepareLevel.lua    LIP.lua    PrintSceneListToTXT    ResetAnimation    AnimationPrewierPlay    Cutscene_Save    file_exists    Cutscene_Load_Clip_Set_Coords    Cutscene_Load_Clip    Cutscene_Load_Agent    CutsceneEditor    move_object 
      �    -�  � @ �@@� � �  �����@    ݀ � C  �  �  �  �-�A @  � FBA ��A � � ]�  �BA ��A   � ��  �BA B @  ݂  CA FCB � ] �  FCA ��B � � ]�  �CA ��B   � ��  �CAD �� �C �CA� ��V���� �C �CA � V���� �C �CAD ��V���� �C �CA� � V���� �C �CA� ��V���� �C �CA � V���� �C �CE   ݃ �   �C�� �� D �E @�� FF � ]����A �EF  �@�
����  ƅF  �@�
݅��A F�F ����
]��  F�F ��
]� ��F � �� ��F  �݆ �F @ � LC� H @ 
�H և�� ]G LC� H @ 
�� ���ǈ� ]G LC� H @ 
�� ���ǈ� ]G LC� H @ 
� � �ǈ� ]G LC� H @ 
�H � �ǈ� ]G �H@�LC� H @ 
�� և�� ]G LC�I  �݇ � ]G b�  �D�LC�D	 � ]D �I @�@<�FCA ��A � � ]�  �CA ��A   � ��  �C@��� �C �C@���	 ��VĄ�� �C �C@��
 � VĄ�� �C   ���CA B @  ݃  DA FDB � ] �  FDA ��B � � ]�  �DA ��B   � ��  �C@��E
 ��VŅ
�� �D �C@���
 � VŅ
�� �D �C@���
 ��VŅ
�� �D �C@�� � 	VŅ
�� �D �CE   ݃ �  �'�[   '�C���D ��	�� D �E @�� FF � ]�!���A �EF  �@�
����  ƅF  �@�
݅��A F�F ����
]��  F�F ��
]� ��F � �� ��F  �݆ �F @ � LC��H @ 
�� և�� ]G LC��H @ 
�� ���ǈ� ]G LC��H @ 
�� ���ǈ� ]G LC��H @ 
� � �ǈ� ]G LC��H @ 
�H � �ǈ� ]G �H@�LC��H @ 
�� և�� ]G LC�I  �݇ � ]G �  @�F�K ����
]���C �AH � 
� IA @	�� 	A� �G ��I ��� ��C@	��I �	 
J FJA �
 ]� VI��� �H �C@	��I �	 
� FJA ��F �
�  �
�]�  VI��� �H ��  #�b�  �D�LC��� ��	� ]D "�  ���MB  � 5      io    open    a    SceneGetAgents    SceneGetCamera 	   tostring    AgentGetName 	   TypeName    AgentGetPos    AgentGetRot    AgentGetWorldPos    AgentGetWorldRot    write         
    Camera Name:     Camera Type:     Camera Position:     Camera Rotation:     Camera World Position:     Camera World Rotation:     AgentGetProperties     --- Camera Properties ---    PropertyGetKeys    ipairs    PropertyGetKeyType    PropertyGet    customKeyToString    Camera     [Camera Property]     Key:  	    Value:      Key Type:      Value Type:     table     Value Table    tprint     ---Camera Properties END ---    pairs     Agent Name:      Agent Type:      Agent Position:      Agent Rotation:      Agent World Position:      Agent World Rotation:      --- Agent Properties ---     [Agent Property]    PropertyGetKeyPropertySet     [Key Property Set]      Key Property Set Key:      Key Property Set Value:      ---Agent Properties END ---    close          {   @F:\Users\777\Desktop\Telltale Modding\telltale-script-editor-win32-x64\cutscene_editor\Cutscene_Editor\CutsceneEditor.lua �                                                        "   "   "   "   "   #   #   #   #   #   $   $   $   $   $   %   %   %   %   %   &   &   &   &   &   '   '   '   '   '   )   )   )   )   *   *   *   *   *   *   +   +   +   +   +   +   ,   ,   ,   ,   ,   ,   -   -   -   -   -   -   .   .   .   .   .   .   /   /   /   /   /   /   1   1   1   3   3   5   5   5   5   8   8   8   ;   ;   ;   ;   =   =   =   =   =   =   >   >   >   >   ?   ?   ?   ?   ?   ?   B   B   B   C   C   C   F   F   F   G   G   G   J   J   J   J   J   J   J   J   K   K   K   K   K   K   K   K   K   L   L   L   L   L   L   L   L   L   M   M   M   M   M   M   M   M   M   N   N   N   N   N   N   N   N   N   Q   Q   R   R   R   R   R   R   R   R   S   S   S   S   S   S   ;   ;   X   X   X   X   ]   ]   ]   ]   _   _   _   _   _   `   `   `   `   `   c   c   c   c   d   d   d   d   d   d   d   e   e   e   e   e   e   e   h   h   i   i   i   i   i   j   j   j   j   j   l   l   l   l   l   m   m   m   m   m   o   o   o   o   o   o   o   p   p   p   p   p   p   p   q   q   q   q   q   q   q   r   r   r   r   r   r   r   v   v   v   y   y   y   y   {   {   {   {   {   {   ~   ~   ~   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   ]   ]   �   �   �   <      SceneObject     �     txtName     �     main_txt_file    �     scene_agents    �     print_agent_transformation 	   �     print_agent_properties 
   �     print_agent_properties_keyset    �     print_scene_camera    �     sceneCamera    �   	   cam_name    �   	   cam_type    �      cam_pos     �      cam_rot %   �      cam_pos_world *   �      cam_rot_world /   �      cam_properties Z   �      cam_property_keys c   �      (for generator) f   �      (for state) f   �      (for control) f   �      b g   �      cam_property_key g   �      cam_property_key_type m   �      cam_property_value q   �      cam_property_value_type w   �      cam_propety_key_string z   �      cam_property_key_type_string }   �      cam_property_value_string �   �      cam_property_value_type_string �   �      (for generator) �   �     (for state) �   �     (for control) �   �     i �   �     agent_object �   �     agent_name �   �     agent_type �   �  
   agent_pos �     
   agent_rot �        agent_pos_world �        agent_rot_world �        agent_properties   �     agent_property_keys '  �     (for generator) *  �     (for state) *  �     (for control) *  �     x +  �     agent_property_key +  �     agent_property_key_type 1  �     agent_property_value 5  �     agent_property_value_type ;  �     agent_propety_key_string >  �     agent_property_key_type_string A  �     agent_property_value_string D  �  !   agent_property_value_type_string G  �     property_key_set �  �     (for generator) �  �     (for state) �  �     (for control) �  �     y �  �     property_key �  �        _ENV �   �     +    @ F@@ @  @ F�@ @ �@ A  �@A �� � A� �� ��A @  B A  �@A �� � A� �� ��A @ �@ F@B �@A ƀB �B FC �� ��A @  B F@B �@A �@C �C F�C �� ��A @  �       ControllerKill    animationPreview    animationPreviewDummy    Custom_SetAgentWorldPosition    Dummy    Vector        Custom_CutsceneDev_SceneObject    Custom_SetAgentRotation    currentAgent_name    x_x    y_y    z_z    r_x    r_y    z_y          {   @F:\Users\777\Desktop\Telltale Modding\telltale-script-editor-win32-x64\cutscene_editor\Cutscene_Editor\CutsceneEditor.lua +   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �             _ENV �   �     +   @@ F�@ ��@ ��  � A F @ �@ @��A F @ �� @� B F @ � � @�@@ E � ��@ �� �� A F@B �@ @��A F@B �� @��B �B  � B F@B �   @�� � B F@B � � @� �       animationPreview    PlayAnimation    currentAgent_name    AnmTextTitle    ControllerSetContribution   �?   ControllerSetPriority   HC   ControllerSetLooping    animationPreviewDummy    mode    @         {   @F:\Users\777\Desktop\Telltale Modding\telltale-script-editor-win32-x64\cutscene_editor\Cutscene_Editor\CutsceneEditor.lua +   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �             _ENV    Dummy �   �     
F      F@@ �   !���@ F�@ G�G��@@ ����  � ��@A F�A G�� G � �@B ƀB �B FC �AC ݀ �B F�C ��C �D � F�A G��GA���A ��A��DƁA ������B FBE 
B�F�E 
B�FBF 
B�F�F 
B�FBG 
B�F�G 
B�
B �
���GB�
B��G��
B�G��
B��GBH
B�G�H
B��G�H
B�
B��
��
�FI J  � %     �?   n_n    currentAgent_name    agents_data    agents_names    agent_number    data    info    animationinput    mode    Vector 
   move_to_x 
   move_to_y 
   move_to_z 	   rot_to_x 	   rot_to_y 	   rot_to_z    speed    r_speed    voice_line    pos_x    x_x    pos_y    y_y    pos_z    z_z    rot_x    r_x    rot_y    r_y    rot_z    r_z    anm    x    y    z 
   save_data          {   @F:\Users\777\Desktop\Telltale Modding\telltale-script-editor-win32-x64\cutscene_editor\Cutscene_Editor\CutsceneEditor.lua F   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �         (for index)          (for limit)          (for step)          i          Save_agent    F      Save_animation    F      Save_animation_type    F      Save_position_move_to    F      Save_rotation_move_to    F      Save_speed    F      Save_r_speed "   F      Save_voice_line %   F      Save_Array C   F         _ENV         F @ G@� �   ��  ]��X�� ��� @ � A� � �@ � � �  @ ��   �   �       io    open    r     close          {   @F:\Users\777\Desktop\Telltale Modding\telltale-script-editor-win32-x64\cutscene_editor\Cutscene_Editor\CutsceneEditor.lua                                            name           f             _ENV      $   F @ G@� G � ��@ ��@ � �� ��@  AAF�@ G�G���� ƀ@ �@  �AF�@ G�G���@ � �AB݀ �B @� � ��B A C @� ����B A  �       agents_data    agents_names    Vector 
   save_data    pos_x    pos_y    pos_z    rot_x    rot_y    rot_z    Custom_SetAgentWorldPosition    Custom_CutsceneDev_SceneObject    Custom_SetAgentRotation          {   @F:\Users\777\Desktop\Telltale Modding\telltale-script-editor-win32-x64\cutscene_editor\Cutscene_Editor\CutsceneEditor.lua $                               	  	  	  	  	  	  	  	  	  	  	  
  
  
  
  
                    number_of_the_agent     $      load_agent_name    $      LoadAgentPos    $      LoadAgentRot    $         _ENV   1   A   @@�A�  � A �@ �A @  � A� V@� @ �F B ��@ ]� [    �F�� ��@ ]� @��A� � C �� a�� ��F�C �D �AC ]��@�F�C @�� �FD �AC ]A `��F�D � E ]� @ �F�E � E ]� @��F�D G � @��F�D G�� @��F�D G � @��F@E G � @��F@E G�� @ �F@E G � @��F H ]@�  � !      animation_menu        load_file_name    Custom_Cutscenes/    cutscene_name    / 	   tostring    .ini    file_exists 
   save_data    load   �?   n_n    aaaaa    check_valifity    pcall    Cutscene_Load_Clip_Set_Coords    NewAgentPos2    AgentGetPos    currentAgent_name    NewAgentRot2    AgentGetRot    x_x    x    y_y    y    z_z    z    r_x    r_y    r_z    Cutscene_Load_Agent           {   @F:\Users\777\Desktop\Telltale Modding\telltale-script-editor-win32-x64\cutscene_editor\Cutscene_Editor\CutsceneEditor.lua A                                                                           '  '  '  '  (  (  (  (  )  )  )  *  *  *  +  +  +  ,  ,  ,  -  -  -  .  .  .  /  /  1        clip     A      (for index)    $      (for limit)    $      (for step)    $      i    #         _ENV    LIP 3  h    w      F@@ �   !���@ F�@ G�G��@@ ����  � ���A F@A @  �A   ��A F@A @  @B   ��A F@A @  �B   ��A F@A @  �B  ���A F@A @   C   ��A �C �B  ���A �C �B  ���A F@A @   D   ��A F@A @  @D  ���A F@A @  �D   ��A F@A @  �D  ���A F@A @   E   ��A F@A @  @E  ���E �E F�B 
@ ��E �E F�B 
@���E �E F@C 
@���E �E F�C 
@���E �E F C 
@ ��E �E F B 
@ �@� A� ��E @��A �F @ �@G� ��A  @ @ ��G�� ��A �G   � H� � !     �?   n_n    currentAgent_name    agents_data    agents_names    agent_number_two    mode 
   save_data    AnmTextTitle    anm    speed    r_speed    voice_line 
   cam_speed    camera    cam_r_speed 
   move_to_x 
   move_to_y 
   move_to_z 	   rot_to_x 	   rot_to_y 	   rot_to_z    data    info    animationinput    save    animation_input.ini     	   modeText 	   IN PLACE    BAKED    @   ROOT MOTION           {   @F:\Users\777\Desktop\Telltale Modding\telltale-script-editor-win32-x64\cutscene_editor\Cutscene_Editor\CutsceneEditor.lua w   6  6  6  6  7  7  7  7  7  7  8  8  6  >  >  >  >  >  ?  ?  ?  ?  ?  @  @  @  @  @  A  A  A  A  A  B  B  B  B  B  C  C  C  C  D  D  D  D  H  H  H  H  H  I  I  I  I  I  J  J  J  J  J  K  K  K  K  K  L  L  L  L  L  M  M  M  M  M  O  O  O  O  P  P  P  P  R  R  R  R  S  S  S  S  U  U  U  U  Y  Y  Y  Y  ^  ^  ^  ^  a  a  a  b  b  c  c  c  d  d  e  e  e  f  h        (for index)          (for limit)          (for step)          i             _ENV    LIP j  �   �     ���  � @ �  � ����@� �@@ �� � �� A ��A�  � �@B�@B�@@B�@@B�@@B�@�D�@E�@B�@@B�@Ō�F�@G���G � �@B��@H �� � FI �A �A B ]� �I �A B AB �� �AI   C  �� �  ��I �  �� �@H �	 @� �I �
 
 A
 �� �I B AB �B ݁ BJ C  �  ݀ ��� J� ʕ J�@@B�@��G � �@�L�@B�@�M�@B�@@B�@@B�@@B�@�   � ��@ �A AA �@�����A �AB��A¡�AB��A¢�AB��A£��M��A�AB��A�AB��A�AB��A�AB��A��M�P FBP 
� �� P � 
AB�
A¡
AB�
A¢
AB�
A£
AB�
A
AB�
A
AB�
A
AB�
A� ��ƀR ���FS �@� � M      cutscene_name    agents_names_path    Custom_Cutscenes/    /agents.ini    agents_data    load    n_n    agents_names    x_x        y_y    z_z    r_x    r_y    r_z    agent_exists_check    animation_menu    mode 	   modeText 	   IN PLACE    root_reset   �?   modeSwitchTime    clipSwitchTime    agentSelectTime    change_angle    change_position ���;   change_position_fast ���=   AnmTextTitle    none    test_variable_switch    AgentCreate    Dummy    dummy.prop    Vector    Custom_CutsceneDev_SceneObject    AgentGetControllers    Dummy_2   z�   kScene    x_x_x    y_y_y    z_z_z    r_x_x    r_y_y    r_z_z    currentAgent_name    input_Swith 
   inputText        speed    r_speed    voice_line    empty 
   move_to_x 
   move_to_y 
   move_to_z 	   rot_to_x 	   rot_to_y 	   rot_to_z    move_to_pos_finish    move_to_rot_finish 
   save_data    agent_number    pos_x    pos_y    pos_z    rot_x    rot_y    rot_z    anm    camera    Callback_OnPostUpdate    Add    move_object           {   @F:\Users\777\Desktop\Telltale Modding\telltale-script-editor-win32-x64\cutscene_editor\Cutscene_Editor\CutsceneEditor.lua �   l  n  n  n  n  n  q  q  q  q  r  r  r  r  u  v  w  z  {  |    �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �        name_of_the_cutscene     �      propp     �      controllersTable_character 7   �      (for index) c   {      (for limit) c   {      (for step) c   {      i d   z      Save_Array w   z         _ENV    LIP    Dummy �      D  @� A�  �   � @  A @A  ���A F�@ X@  ���A @� @B�� F�B �� !���@ FC GA�G��@  ��B� ���C @B   � � @B� @  A @A   � D F�A �  ���D F�A �  ���C  E  ���C �E  ���C  F  ��@D  E  ��@D �E   �@D  F  �� G @� �G F�G �  ���G F@H �   � B @B �� D A� �   ��D A� �   �@I F�A ��I ��D AE F�E �� ��I @  J F�A ��I �@F �F F�F �� ��I @ @i� B �B �h�@J @B  *��J @B ���@I F�A ��I ��D AE F�E �� ��I @ @��I F�D �@E ��E � F�I � K �@K �K ]� � � � E �� ǀ� �E � �� GF AF�K ]�� �L ƁJ ��@ ��FAL ���	�F�K ]�� @�FAI ��A ƁI �D FBE ��E ݁ �I ]A ��@F�K ]�� �L N����I �E BF�J B���E OB���J P��BGF �BƂJ ��M���� �AI �A @ ��I �A �L @B ��� J F�A ��I �@F �F F�F �� ��I @ @O��I F@F ��F ��F � F�I ��L � M AM ]� � � � E �� ǀ� �E � �� GF AF�K ]�� ��M ƁL ��@ ��F�J ���G�F�K ]�� @�FJ ��A ƁI BF F�F ��F ݁ �I ]A �D�@F�K ]�� ��M N����I �E BF�L B���E OB���L P��BGF �BƂL ��M���� �J �A @ ��I �A �=�@J �B ���I F�D �@E ��E � F�I �@F ƀF �F ]� � D �� �� ƀD � ݀ �F NAN ��E GE��N ��N��M �� O��AGF��N �O��M �� O��A
 ��E G�EA
 �F GF��N ��N��M �� O��AGE��N �O��M �� O��A
 �� G�AJ ��� G��AJ �� G�AJ �AI F�A �  ��I A J F�A �� ��I A  )�@J @O @(��O @B @��A @� �O @� @B��B��I F�D �@E ��E � F�I �@F ƀF �F ]� � D �� �� ƀD � ݀ EF�H G��P O��A� ��EF�H G���P O��A� �FF�H G��P O��A� ��FI G��P O��A� ���FI G���P O��A� ��FI G��P O��A� ��F NAN ��E GE��N ��N��M �� O��AGF��N �O��M �� O��A
 ��E G�EA
 �F GF��N ��N��M �� O��AGE��N �O��M �� O��A
 �� G�AJ ��� G��AJ �� G�AJ �AI F�A �  ��I A J F�A �� ��I A AP F�P � �P��D A� �  ��D A� �  �Q E �AH �� �AQ F�P �� A��Q F�P �� A�R F�P �  A�P �B ��K �� F@R  � @��R A� �     � S @B � �@O��Ӧ@ �@B��Ӧ�K �� �S  �� ��K �� F@R  � @��R A  �     � S @B � ��B��Ӧ@ �@B��Ӧ�K �� �S  ��@��K �� F@R  �  ��R A@ �    �� S @B ���T��D  ��@E   ��E  ��@F   ��F  ���F   ��Ӧ@ �@B��Ӧ�K �� �S  �� S �B �/��A @� @B�@B��K �� F@R  � �)��R A@ �     �@S A� @   ���K �� �S  ��@&��R A� �     �@S A  @   ���K �� �S  ���"��R A@ �     �@S A� @   ���K �� �S  ��@��R A� �     �@S A  @   ���K �� �S  �����R A@ �     �@S A� @   ���K �� �S  ��@��R A� �     �@S A  @   ���K �� �S  �����R A@ �     �@S A� @   ���K �� �S  ��@��R A� �     �@S A  @   ���K �� �S  �����R A@ �     �@S A� @   ���K �� �S  ��@
��R A� �     �@S A  @   ���K �� �S  �����R A@ �     �@B�� F�[ �  �@S A   F�� �   ��\ ]@� � @��R A  �     �@B�@] F@S @  � @S F�] ��] �   ]@�F ^ ��] ƀI �D FAE ��E �  ]@   � �v� S @O ���A @� @B�@B��^ A� � _ �� �� D A� � F�D �� ]� �@ ƀ_    ݀ � F�_ �� ]� �@�����K ��� �@R ������R �� �� �    ���\ � `� E ������\ � `ǀE �� ���\ � `� F ������\ � `� � �� �\ � `ƀa ����\ � `� � ���Æ�K ��� ��S��� ���R �@ �� �   �	���\ � `� E �� ���\ � `ǀE ������\ � `� F �� ���\ � `� � ������\ � `ƀa �� ���\ � `� � ������\ � `� @ � �� ��� ���\ � `� @ � ��@��� ���K ��� ��S����@S ƀ] �] @ �@�� ^ �] F�I ��D �AE �E ] �@   � �V� S �T  A��A @� @B�@B��R A�" �    ���R A�" �     ��T F c @   ��@��R A@# �     ��U F�c @    �� ��T F�c @   ���R A $ �    ���R A�" �     ��T F c @   ��@��R A@# �     ��U F�c @    �� ��T F�c @   ���R A@$ �    ���R A�" �     �@U F c @   ��@��R A@# �     ��U F�c @   ��� �@U F�c @   ���R A�$ �    ���R A�" �     �@U F c @   ��@��R A@# �     ��U F�c @   ��� �@U F�c @   ���R A�$ � @   ��R A % �    ���R A�" �     � U F c @    �@��R A@# �     � V F�c @    �� � U F�c @    ��R A@% � @   ��R A�% �    ���R A�" �     � U F c @    �@��R A@# �     � V F�c @    �� � U F�c @    ��I F�T � U �@U � F�I ��U ��U V ]� ��% ƀ_    ݀ & F�_ �� ]� �@����@S ƀ] �] @ �@�� ^ �] F�I ��T �U BU ] �@  �@I A& @  ��I �@ � J A& @� ��I �@ ��K ݀� AR � ��ƀR � ݀ �   @���T � �� U ����@U � �ƀU �����U � �� V �����K ݀� ������@B� �  � ��@I A@& ��I ��& �& A�& �� ��I @ �A @   ��& �� @   � ' ƀ_ �I F�D �AE ��E  ݀  �&  � @   �@' ƀ_ �I FAF ��F ��F  ݀  �&  � @   ��' ��g AH ݀ �&  � @   � ( ��g B ݀ �&  � @   �@( ��g �h ݀ �& A�( ��g �H �� ��& ) F�g �BG ]� ��& �� @   �@) ��g �G ݀ �� F�] ��] �   ]@�F ^ ��] ƀI �D FAE ��E �  ]@  �R A�" �    ���R A�" �     ��D F c @   ��@��R A@# �     �@F F�c @   ��� ��D F�c @   ���R A $ �    ���R A�" �     ��D F c @   ��@��R A@# �     �@F F�c @   ��� ��D F�c @   ���R A@$ �    ���R A�" �     ��E F c @   ��@��R A@# �     ��F F�c @    �� ��E F�c @   ���R A�$ �    ���R A�" �     ��E F c @   ��@��R A@# �     ��F F�c @    �� ��E F�c @   ���R A�$ � @   ��R A % �    ���R A�" �     �@E F c @   ��@��R A@# �     ��F F�c @   ��� �@E F�c @   ���R A@% � @   ��R A�% �    ���R A�" �     �@E F c @   ��@��R A@# �     ��F F�c @   ��� �@E F�c @   �� @  A �i  �� @  A �J   � @  A �L   � @  A �G  ���R A�) �    �� B @B ��@J X@O @ ��O @� �B��K ��   ��K ��   ��R A * �    �� B �B � ��A @� @B�@B��R A@* �     ��K �� F@R  � �	�@J �B  ��@J  ��  �@@J @B  ��A @�  B �B @ ��O @� �j� �@J �B  ��A @�  B �B @ ��O @� �j� �@J @O @ � k�@B��K �� @k  ���R A�+ �    �	��K �� F@R  � ���A @� �g F�G � A�+ @  F�g ��G ]� � , V�� �@l � � �� � Q �A @  ݀�AQ @��� A��Q @���, A�R @��  A��K �� Ak ���l @�  � �      data    load    animation_input.ini    currentAgent_name_check    info    agent_name    currentAgent_name    ResetAnimation    animation_menu       �?   n_n    agents_data    agents_names    agent_exists_check    NewAgentPos    AgentGetPos    NewAgentRot    AgentGetRot    x_x    x    y_y    y    z_z    z    r_x    r_y    r_z    Cutscene_Load_Agent    VoiceLength    AnimationGetLength    voice_line    AnimationLength    AnmTextTitle    DummyPosNew    Dummy    DummyRotNew    Custom_SetAgentWorldPosition    Vector    Custom_CutsceneDev_SceneObject    Custom_SetAgentRotation    mode    speed    move_to_pos_finish 
   move_to_x 
   move_to_y 
   move_to_z    GetTotalTime    move_start_time_pos    move_to_rot_finish    r_speed 	   rot_to_x 	   rot_to_y 	   rot_to_z    move_start_time_rot 	   OffSet_y �I@  4C   math    cos    sin    @   root_reset    AnimationPrewierPlay    root_iteration    ControllerIsPlaying    animationPreviewDummy     PlayAnimation    ControllerSetContribution    ControllerSetPriority   HC   ControllerSetLooping    modeSwitchTime    Custom_InputKeyPress   �@   input_Swith 
   inputText     ���>  �B  �B  @@   x_x_x    y_y_y    z_z_z    r_x_x    r_y_y    r_z_z   @B   0   DB   1   HB   2   LB   3   PB   4   TB   5   XB   6   \B   7   `B   8   dB   9   4B   Custom_Cutscenes/    cutscene_name    /    .ini    save 
   save_data   8B   Cutscene_Load_Clip    TextSet .   Custom_CutsceneDev_CutsceneToolsHighlightText    AgentSetWorldPos    agent_free_camera    AgentFindInScene    myNewFreecamera    kScene    CAMERA MODE
POS:     VectorToString    
ROT:     camera    pos_x    pos_y    pos_z    rot_x    rot_y -   Custom_CutsceneDev_Freecam_InputMouseAmountX    rot_z    cam_r_speed 
   cam_speed   B  �A   change_position_fast   �A   change_angle    change_position    B  B  B  �B  ;C  �B  =C   Move_To_Pos:     
Move_To_Rot:     Dummy_2   z�   
    World Pos:     World Rot:     Current anm:  	   tostring 
   Playing:     Mode:  	   modeText    Animation Length:     Voiceline Length:     Voice line:     animationinput    B  PA  A	   IN PLACE    BAKED    ROOT MOTION ��?  �B   .anm    .wav 
   SoundPlay   �C   Cutscene_Save           {   @F:\Users\777\Desktop\Telltale Modding\telltale-script-editor-win32-x64\cutscene_editor\Cutscene_Editor\CutsceneEditor.lua D  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �                                                                    	  	  	  
  
  
                                                                                                                 !  !  !  !  "  "  "  "  "  "  "  "  "  "  "  "  "  "  "  "  "  #  #  #  #  #  '  '  '  (  )  )  )  )  )  )  )  )  )  )  ,  ,  ,  ,  ,  -  -  -  -  -  /  /  /  0  0  0  1  1  1  4  4  4  4  4  4  4  5  6  6  6  8  8  8  9  9  9  9  9  9  9  9  9  :  <  =  =  =  =  >  >  >  >  >  >  >  >  >  >  >  >  >  >  >  >  >  ?  ?  ?  ?  ?  A  C  C  C  D  D  D  D  D  E  E  E  E  E  F  F  F  G  G  G  J  J  J  J  L  L  L  L  L  L  L  L  L  L  L  L  L  L  L  L  M  M  M  M  N  N  N  N  N  N  N  N  N  N  N  N  N  N  N  N  R  R  R  R  S  S  S  S  T  T  T  T  Z  Z  Z  Z  Z  [  [  [  [  [  [  \  \  \  ^  ^  ^  `  `  a  a  c  d  g  g  g  g  g  h  h  h  h  h  i  i  i  j  j  j  l  l  l  l  l  l  l  m  m  m  m  m  m  m  n  n  n  n  n  n  n  q  q  q  q  q  q  q  r  r  r  r  r  r  r  s  s  s  s  s  s  s  u  u  u  u  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  w  x  x  x  x  y  y  y  y  y  y  y  y  y  y  y  y  y  y  y  y  {  {  {  {  |  |  |  |  }  }  }  }  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �                                                                           	  	  	  	  	                                                                                                                                             !  !  !  !  !  "  "  "  "  "  #  #  #  #  #  $  $  $  $  $  &  &  &  &  *  *  *  *  *  +  +  +  +  +  ,  ,  ,  ,  ,  -  -  -  -  -  .  .  .  .  .  0  0  0  0  4  4  4  4  4  5  5  5  5  5  6  6  6  6  6  7  7  7  7  7  8  8  8  8  8  :  :  :  :  >  >  >  >  >  ?  ?  ?  ?  ?  @  @  @  @  @  A  A  A  A  A  B  B  B  B  B  D  D  D  D  I  I  I  I  I  I  I  I  I  I  J  J  J  J  J  K  K  K  K  K  L  L  L  L  L  M  M  M  M  M  O  O  O  O  S  S  S  S  S  S  S  S  S  S  T  T  T  T  T  U  U  U  U  U  V  V  V  V  V  W  W  W  W  W  Y  Y  Y  Y  \  \  \  \  \  ]  ]  ]  ]  ]  _  _  _  _  _  _  _  _  _  _  `  a  a  a  a  b  b  b  b  b  b  b  b  d  d  d  d  d  e  e  e  e  e  h  h  h  h  h  i  i  i  i  i  j  j  k  k  l  l  m  m  n  n  o  o  p  p  p  p  q  r  u  u  w  w  w  w  w  w  w  w  w  y  z  z  z  {  {  {  {  {  {  {  {  {  {  {  |  |  |  |  |  |  |  |  |  |  |  }  }  }  }  }  }  }  ~  ~  ~  ~  ~  ~  ~                                    �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �                                                            	  	  	  	        '      (for index)          (for limit)          (for step)          i       
   Position1    �   
   Position2 �   �   	   length_x �   �   	   length_y �   �   	   length_z �   �      time_passed_pos �   �   
   Position3 �   �   
   Rotation1 �     
   Rotation2 �        r_length_x �        r_length_y �        r_length_z �        time_passed_rot �     
   Rotation3        ControllerPos   f     ControllerRot "  f  	   DummyPos %  f  	   DummyRot (  f     ControllerPos x       ControllerRot }    	   DummyPos �    	   DummyRot �       save_file_name         highlightedText        SaveCameraPosition .  �     SaveCameraRotation 1  �     highlightedText �  �  
   Dummy2Pos b  �  
   Dummy2Rot g  �     highlightedText r  �     highlightedText �  �     voice_line_anm %  A     voice_line_snd *  A     controller_sound -  A     voiceController 1  A        _ENV    LIP    Dummy     {   @F:\Users\777\Desktop\Telltale Modding\telltale-script-editor-win32-x64\cutscene_editor\Cutscene_Editor\CutsceneEditor.lua 7                                                                           	   	   	   
   
   
               �   �   �   �   �   �   �   �           1  1  h  h  �  �              LIP !   7      Dummy "   7         _ENV 