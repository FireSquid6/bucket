GDPC                 �                                                                         P   res://.godot/exported/133200997/export-00d07ad8f22d79b82c730f077eb6bc65-chat.scn�       j      ������X,�Q�!��    P   res://.godot/exported/133200997/export-3070c538c03ee49b7677ff960a3f5195-main.scn�      &      �_��
�bp��tC1 z    \   res://.godot/exported/133200997/export-319b7070da2e52dfd3a156a8d6f72b44-server_console.scn  �      �      m'���ug�o�؄���    T   res://.godot/exported/133200997/export-399d989b856dec99c2e8a5ad508ee24f-server.scn  0      p      �g&�SԪ���
l�=    T   res://.godot/exported/133200997/export-ceda2f081d5fe9dde191c8239239e4c3-client.scn         p      췸y6�fT���ɪ    T   res://.godot/exported/133200997/export-dec10ffa02c2fe67f5ba39b533fca896-chatroom.scn�            TI	�:f�~�}Ro�K    ,   res://.godot/global_script_class_cache.cfg  `#             ��Р�8���8~$}P�    D   res://.godot/imported/icon.png-487276ed1e3a0c39cad0279d744ee560.ctex@            ����~MN
�3��S�       res://.godot/uid_cache.bin  �#            �1�1����oXPOy��       res://chat/chat.gd          �       Z{w(�f㉉м{�0��       res://chat/chat.tscn.remap  �       a       R�y�yn�O�=U�.       res://chatroom/chatroom.gd  `      G      F�u�4��c�x����    $   res://chatroom/chatroom.tscn.remap  0!      e       1q���|'��c뮙�       res://client/client.gd  �
      +      N��q��^��)�5s�1]        res://client/client.tscn.remap  �!      c       ��'S^#���J�qy       res://icon.png.import   P      �        X��(oY{�A�,`       res://main.gd         u      ���BV��\=�T/v5�       res://main.tscn.remap   �"      a       �J�Sw� ������       res://project.binary�$      �      �?���b�*����       res://server/server.gd  p      �      ��ɹ�a��q:h��        res://server/server.tscn.remap  "      c       ����m�!ׁP�m@��    0   res://server_console/server_console.tscn.remap  �"      k        ��>�O�p,��ę        extends Node

signal message_recieved(msg: String)

@rpc("any_peer", "call_local", "reliable")
func _send_message(msg: String):
	print(msg)
	emit_signal("message_recieved", msg)

func send_message(msg: String):
	_send_message.rpc(msg)
     RSRC                    PackedScene            ��������                                                  resource_local_to_scene    resource_name 	   _bundled    script       Script    res://chat/chat.gd ��������      local://PackedScene_3jjfh 
         PackedScene          	         names "         Chat    script    Node    	   variants                       node_count             nodes     	   ��������       ����                    conn_count              conns               node_paths              editable_instances              version             RSRC      extends Control


func _ready():
	Chat.connect("message_recieved", _on_new_message)

func _on_button_pressed():
	var message = $TextEdit.text
	Chat.send_message(message)
	$TextEdit.text = ""


func _on_new_message(msg):
	var label: Label = Label.new()
	label.text = msg
	
	$Panel/ScrollContainer/VBoxContainer.add_child(label)
         RSRC                    PackedScene            ��������                                                  resource_local_to_scene    resource_name 	   _bundled    script       Script    res://chatroom/chatroom.gd ��������      local://PackedScene_avkau          PackedScene          	         names "      	   Chatroom    layout_mode    anchors_preset    anchor_right    anchor_bottom    grow_horizontal    grow_vertical    script    Control 	   TextEdit    offset_left    offset_top    offset_right    offset_bottom    placeholder_text    Button    text    Panel    ScrollContainer    VBoxContainer 
   alignment    _on_button_pressed    pressed    	   variants                        �?                            �A     �C    �D    ��C      type your message here...     �D     �C     ,D     �C      Send      �A      A    �,D    ��C            node_count             nodes     j   ��������       ����                                                          	   	   ����         
                     	      
                     ����         
                                                ����         
                                         ����                                                        ����                         conn_count             conns                                      node_paths              editable_instances              version             RSRC   extends Node

var peer = null

func connect_to_server(ip: String):
	peer = ENetMultiplayerPeer.new()
	peer.create_client(ip, 3412)
	multiplayer.multiplayer_peer = peer
	multiplayer.connected_to_server.connect(_on_connect)


func _on_connect():
	print("connected to server")
	Server.rpc("do_output")
     RSRC                    PackedScene            ��������                                                  resource_local_to_scene    resource_name 	   _bundled    script       Script    res://client/client.gd ��������      local://PackedScene_xwt1o          PackedScene          	         names "         Client    script    Node    	   variants                       node_count             nodes     	   ��������       ����                    conn_count              conns               node_paths              editable_instances              version             RSRCextends Node


var peer = null
const PORT = 3412
const MAX_CLIENTS = 24  # subject to change

func start_server():
	peer = ENetMultiplayerPeer.new()
	peer.create_server(PORT, MAX_CLIENTS)
	multiplayer.multiplayer_peer = peer
	multiplayer.peer_connected.connect(peer_connected)
	print(IP.get_local_addresses())


@rpc("any_peer")
func do_output():
	print("Hey! I'm some output")


func peer_connected(id: int):
	print("Player connected " + str(id))
RSRC                    PackedScene            ��������                                                  resource_local_to_scene    resource_name 	   _bundled    script       Script    res://server/server.gd ��������      local://PackedScene_ko7mw          PackedScene          	         names "         Server    script    Node    	   variants                       node_count             nodes     	   ��������       ����                    conn_count              conns               node_paths              editable_instances              version             RSRCRSRC                    PackedScene            ��������                                                  resource_local_to_scene    resource_name 	   _bundled    script           local://PackedScene_ru1f0 �          PackedScene          	         names "         ServerConsole    layout_mode    anchors_preset    anchor_right    anchor_bottom    grow_horizontal    grow_vertical    Control    Label    offset_right    offset_bottom    text    	   variants                        �?                   B     �A      Currently Running a Server       node_count             nodes     "   ��������       ����                                                          ����         	      
                      conn_count              conns               node_paths              editable_instances              version             RSRC          GST2   �   �      ����               � �        �  RIFF�  WEBPVP8L�  /� w���m��$�h#�r"H�o`��(��梂��+ ^���$5@HL��!� z��p�x� ��/Jf�����*ˀ2�Ce%C_$�z#Vm�u#S(�R(Q��P
�0.��
�`zX�?֚���3R�F�}	tf	l��0��$�����%ژ�U�>{�>\�>{�{��-W�> 2@�}��#@���_�yS��W&�$Db :`'�$��	0>=f��5Ϗ������zq��ON�f��px�"�r�� ! t L՚��t���Q8?j����sr�x:?��\������e�N�ފyzB0Bz�����xD�� {��)U�\��S��6���8�=vk� &wxw:l�y~D�	&�^|����Ww^l���ճ�bc��T=؈6Ϊ�~~V31c�$v�W�T����_/`����`/               [remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://4sn75ymakd0p"
path="res://.godot/imported/icon.png-487276ed1e3a0c39cad0279d744ee560.ctex"
metadata={
"vram_texture": false
}
 extends Control

var chatroom_scene = preload("res://chatroom/chatroom.tscn")
var server_scene = preload("res://server_console/server_console.tscn")

func _on_button_pressed():
	Client.connect_to_server($TextEdit.text)
	get_tree().change_scene_to_packed(chatroom_scene)


func _on_button_2_pressed():
	Server.start_server()
	get_tree().change_scene_to_packed(server_scene)
           RSRC                    PackedScene            ��������                                                  resource_local_to_scene    resource_name 	   _bundled    script       Script    res://main.gd ��������      local://PackedScene_81wdg          PackedScene          	         names "      	   MainMenu    layout_mode    anchors_preset    anchor_right    anchor_bottom    grow_horizontal    grow_vertical    script    Control    Button    anchor_left    anchor_top    offset_left    offset_top    offset_right    offset_bottom    text    Button2 	   TextEdit    placeholder_text    _on_button_pressed    pressed    _on_button_2_pressed    	   variants                        �?                                  ?     ��     ��     �B     �B      Connect       �             Become the Server      �C    ��C    @ED    ��C   	   Enter IP       node_count             nodes     f   ��������       ����                                                          	   	   ����               
                                 	      
                                       	      ����                
                                                                        ����                                                 conn_count             conns                                                              node_paths              editable_instances              version             RSRC          [remap]

path="res://.godot/exported/133200997/export-00d07ad8f22d79b82c730f077eb6bc65-chat.scn"
               [remap]

path="res://.godot/exported/133200997/export-dec10ffa02c2fe67f5ba39b533fca896-chatroom.scn"
           [remap]

path="res://.godot/exported/133200997/export-ceda2f081d5fe9dde191c8239239e4c3-client.scn"
             [remap]

path="res://.godot/exported/133200997/export-399d989b856dec99c2e8a5ad508ee24f-server.scn"
             [remap]

path="res://.godot/exported/133200997/export-319b7070da2e52dfd3a156a8d6f72b44-server_console.scn"
     [remap]

path="res://.godot/exported/133200997/export-3070c538c03ee49b7677ff960a3f5195-main.scn"
               list=Array[Dictionary]([])
        �i�{�Q�   res://chat/chat.tscn୮���a   res://chatroom/chatroom.tscn��� ׺J   res://client/client.tscn��%�S!P   res://server/server.tscn�-'A�2]   res://icon.svgƺ)tC�0{   res://main.tscn�=ߘm�	(   res://server_console/server_console.tscn���~�   res://icon.png         ECFG      application/config/name         Teleorb Game   application/run/main_scene         res://main.tscn    application/config/features   "         4.2    Mobile     application/config/icon         res://icon.svg     autoload/Client$         *res://client/client.tscn      autoload/Server$         *res://server/server.tscn      autoload/Chat          *res://chat/chat.tscn   #   rendering/renderer/rendering_method         mobile                 