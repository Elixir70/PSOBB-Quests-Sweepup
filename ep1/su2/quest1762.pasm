0:      set_episode 00000000
        leti R50, 00000000
        leti R51, 00000000
        leti R52, 00000000
        leti R53, 00000000
        leti R54, 00000000
        map_designate_ex R50
        leti R50, 00000005
        leti R51, 00000005
        leti R52, 00000000
        leti R53, 00000001
        leti R54, 00000000
        map_designate_ex R50
        set_floor_handler 00000000, 150
        set_floor_handler 00000005, 250
        set_qt_exit 330
        set_qt_cancel 340
        set_qt_success 350
        set_qt_failure 360
        get_slotnumber R250
        get_difflvl2 R251
        set_mainwarp 00000005
        thread 260
        thread 251
        thread 1500
        call 4
1:      ret 
        message 00000069, '** 2: disables movement at start'
2:      disable_movement2 R250
        p_action_disable 
        hud_hide 
        cine_enable 
        cam_zmin 
        ret 
        message 00000069, '** 3: Enables movement at start''
3:      enable_movement2 R250
        p_action_enable 
        hud_show 
        cine_disable 
        cam_zmout 
        ret 
        nop 
        nop 
        nop 
        message 00000069, '** 4 to 9 -- setup max timer in seconds'
        message 00000069, '** R200 = max timer in seconds. R199 = max timer in minutes.'
4:      jmpi_= R251, 00000000, 5
        jmpi_= R251, 00000001, 6
        jmpi_= R251, 00000002, 7
        jmpi_= R251, 00000003, 8
5:      leti R200, 000004B0
        jmp 9
6:      leti R200, 00000384
        jmp 9
7:      leti R200, 000002D0
        jmp 9
8:      leti R200, 00000258
        jmp 9
9:      let R199, R200
        divi R199, 0000003C
        ret 
11:     switch_jmp R230, 2:1:12
12:     nop 
        nop 
        ret 
        nop 
        nop 
        nop 
330:    ret 
340:    ret 
360:    sync 
        ret 
        nop 
        nop 
        message 00000069, '** 350->355 - Reward meseta'
        nop 
350:    bgm 00000001
        jmpi_= R251, 00000000, 351
        jmpi_= R251, 00000001, 352
        jmpi_= R251, 00000002, 353
        jmpi_= R251, 00000003, 354
        ret 
        nop 
        nop 
351:    leti R220, 000001F4
        pl_add_meseta2 000001F4
        jmp 355
352:    leti R220, 000007D0
        pl_add_meseta2 000007D0
        jmp 355
353:    leti R220, 00001388
        pl_add_meseta2 00001388
        jmp 355
354:    leti R220, 00002EE0
        pl_add_meseta2 00002EE0
        jmp 355
355:    window_msg 'You've received <color 1><r220><color 0> Meseta.'
        winend 
        ret 
        nop 
        nop 
        nop 
        message 00000069, '** 150-151 positions players at start of quest'
150:    switch_jmp R0, 2:151:11
151:    leti R1, 000000ED
        leti R2, 00000000
        leti R3, 0000014D
        leti R4, FFFFFFF1
        p_setpos 00000000, R1
        leti R1, 000000FF
        leti R2, 00000000
        leti R3, 00000152
        leti R4, FFFFFFD5
        p_setpos 00000001, R1
        leti R1, 000000DE
        leti R2, 00000000
        leti R3, 00000142
        leti R4, 00000019
        p_setpos 00000002, R1
        leti R1, 000000F8
        leti R2, 00000000
        leti R3, 00000143
        leti R4, FFFFFFEC
        p_setpos 00000003, R1
        call 2
        jmp 310
        message 00000069, '** 310 is works soldier dialogue at start'
310:    jmpi_= R254, 00000001, 313
        jmpi_= R252, 00000001, 312
        jmpi_= R0, 00000001, 311
        chat_box 00000064, 00000064, 0000000C, 00000001, 00000001, 'Skip dialogue?'
        winend 
        list R20, 'No<cr>Yes'
        jmpi_= R20, 00000001, 152
        message 00000069, 'Welcome back. Same type<cr>of mission as last time.'
        add_msg 'Sweep the Caves for<cr>monsters, then I'll send my unit.'
        add_msg 'You have <r199> minutes. Good luck!'
        mesend 
152:    set R0
        bgm 00000001
        call 3
        ret 
        nop 
        nop 
        nop 
311:    message 00000069, 'Report to me when you've<cr>completed the mission.'
        mesend 
        ret 
312:    message 00000069, 'Looks like you failed.'
        add_msg 'Don't worry, we'll handle<cr>it from here.'
        mesend 
        set R253
        ret 
313:    message 00000069, 'You killed all the<cr>monsters? Good job.'
        add_msg 'We'll start our mission<cr>now. Get your reward at<cr>the Hunter's Guild.'
        mesend 
        set R255
        ret 
250:    jmpi_= R254, 00000001, 11
        jmpi_= R252, 00000001, 11
        sync_register R210, 00000001
        thread_stg 1011
        switch_jmp R230, 2:259:11
259:    ret 
        nop 
        nop 
        nop 
        message 00000069, '** 251 starts timer. R200 max time, R203 current time.'
251:    sync 
        jmpi_= R210, 00000000, 251
        switch_jmp R230, 2:258:1
258:    gettime R201
        set R230
        sync 
        let R202, R201
        addi R202, 0000001E
        let R202, R201
        add R202, R200
261:    window_time 
252:    sync 
        jmpi_= R254, 00000001, 1
        let R203, R202
        gettime R201
        sub R203, R201
        jmpi_<= R203, 00000000, 262
        winset_time R203
        jmpi_>= R203, 00000000, 261
        message 00000069, '** R203 <= 0, so we ran out of time. Time to fail quest.'
262:    leti R204, 00000000
        winset_time R204
        winend_time 
        freeze_enemies 
        disable_movement2 R250
        p_action_disable 
        p_disablewarp 
        warp_off 
        set R252
        thread 253
        clear_mainwarp 00000005
        sync_register R253, 00000001
        window_msg '              TIME UP!'
        winend 
        ret 
        nop 
        nop 
        nop 
        message 00000069, '** Thread that checks if final door is opened (quest cleared).'
260:    sync 
        leti R240, 00000005
        leti R241, 00000014
        if_switch_pressed R240
        jmpi_= R242, 00000000, 260
        p_action_disable 
        set R254
        window_msg '         Mission complete!'
        se 00000001
        winend 
        bgm 00000000
        window_msg 'You will be taken to the lobby<cr>after you receive your reward.'
        winend 
        p_action_enable 
        ret 
        message 00000069, '** This is done because the spawns in those rooms are threaded.'
        message 00000069, '** 1011 is start of two loops that check for rooms cleared'
        message 00000069, '** 1011: Checks room 51, 1012 checks room 54'
        message 00000069, 'sw_send is used instead of unlock_door2'
1011:   sync 
        leti R60, 00000005
        leti R61, 00000033
        if_zone_clear R62, R60
        jmpi_= R62, 00000000, 1011
        setevt 000001FE
1012:   sync 
        leti R60, 00000005
        leti R61, 00000036
        if_zone_clear R62, R60
        jmpi_= R62, 00000000, 1012
        setevt 0000021C
        ret 
        message 00000069, '** Time up code below. Return to guild, disable warp.'
253:    fadeout 
        unfreeze_enemies 
        set R207
        p_return_guild 
        p_action_enable 
        enable_movement2 R250
1080:   leti R1, 0000000A
        leti R2, 00000000
        leti R3, 000000C8
        leti R4, 0000005A
        p_setpos 00000000, R1
        p_setpos 00000001, R1
        p_setpos 00000002, R1
        p_setpos 00000003, R1
        ret 
        nop 
        nop 
        nop 
1109:   ret 
        nop 
        nop 
        nop 
1201:   message 0000042C, 'Was it more difficult than you imagined?'
        mesend 
        nop 
        nop 
        nop 
1500:   sync 
        jmp 1500
        nop 
