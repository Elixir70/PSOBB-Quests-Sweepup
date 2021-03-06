0:      set_episode 00000001
        leti R50, 00000003
        leti R51, 00000015
        leti R52, 00000000
        leti R53, 00000001
        leti R54, 00000000
        map_designate_ex R50
        leti R50, 00000000
        leti R51, 00000012
        leti R52, 00000000
        leti R53, 00000000
        leti R54, 00000000
        map_designate_ex R50
        set_floor_handler 00000000, 150
        set_floor_handler 00000003, 250
        set_qt_exit 330
        set_qt_cancel 340
        set_qt_success 350
        set_qt_failure 360
        get_slotnumber R250
        get_difflvl2 R251
        set_mainwarp 00000003
        thread 260
        thread 251
        thread 1500
        call 4
1:      ret 
        message 0000041A, '** 2: Disables movement at start'
2:      disable_movement2 R250
        p_action_disable 
        hud_hide 
        cine_enable 
        cam_zmin 
        ret 
        message 0000041A, '** 3: Enables movement at start''
3:      enable_movement2 R250
        p_action_enable 
        hud_show 
        cine_disable 
        cam_zmout 
        ret 
        nop 
        nop 
        nop 
        message 0000041A, '** 4 to 9 -- setup max timer in seconds'
        message 0000041A, '** R200 = max timer in seconds. R199 = max timer in minutes.'
4:      jmpi_= R251, 00000000, 5
        jmpi_= R251, 00000001, 6
        jmpi_= R251, 00000002, 7
        jmpi_= R251, 00000003, 8
5:      leti R200, 00000438
        jmp 9
6:      leti R200, 000003C0
        jmp 9
7:      leti R200, 00000384
        jmp 9
8:      leti R200, 00000348
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
        message 0000041A, '** 350->355 - Reward meseta'
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
        message 0000041A, '** 150-151 positions players at start of quest'
150:    switch_jmp R0, 2:151:11
151:    leti R1, FFFFD8E7
        leti R2, 0000001E
        leti R3, FFFFFF4C
        leti R4, 000000B4
        p_setpos 00000000, R1
        leti R1, FFFFD8F6
        leti R2, 0000001E
        leti R3, FFFFFF4C
        leti R4, 000000B4
        p_setpos 00000001, R1
        leti R1, FFFFD8F6
        leti R2, 0000001E
        leti R3, FFFFFF45
        leti R4, 000000B4
        p_setpos 00000002, R1
        leti R1, FFFFD901
        leti R2, 0000001E
        leti R3, FFFFFF45
        leti R4, 000000B4
        p_setpos 00000003, R1
        call 2
        jmp 310
        message 0000041A, '** 310 is Natasha dialogue. Her ID is 100 (64)'
310:    jmpi_= R254, 00000001, 313
        jmpi_= R252, 00000001, 312
        jmpi_= R0, 00000001, 311
        chat_box 00000064, 00000064, 0000000C, 00000001, 00000001, 'Skip dialogue?'
        winend 
        list R20, 'No<cr>Yes'
        jmpi_= R20, 00000001, 152
        message 00000064, 'Welcome back. Same type<cr>of mission as last time.'
        add_msg 'Sweep the Spaceship for<cr>monsters then I'll send<cr>my unit.'
        add_msg 'You have <r199> minutes. Good luck!'
        mesend 
152:    set R0
        bgm 00000001
        call 3
        ret 
        nop 
        nop 
        nop 
311:    message 00000064, 'Report to me when you've<cr>completed the mission.'
        mesend 
        ret 
312:    message 00000064, 'Looks like you failed.'
        add_msg 'Don't worry, we'll handle<cr>it from here.'
        mesend 
        set R253
        ret 
313:    message 00000064, 'You killed all the<cr>monsters? Good job.'
        add_msg 'We'll start our mission<cr>now. Get your reward at<cr>the Hunter's Guild.'
        mesend 
        set R255
        ret 
250:    jmpi_= R254, 00000001, 11
        jmpi_= R252, 00000001, 11
        sync_register R210, 00000001
        thread_stg 1011
        thread_stg 270
        thread_stg 280
        switch_jmp R230, 2:259:11
259:    ret 
        nop 
        nop 
        nop 
        message 0000041A, '** 251 starts timer. R200 max time, R203 current time.'
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
        message 0000041A, '** R203 <= 0, so we ran out of time. Time to fail quest.'
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
        clear_mainwarp 00000003
        sync_register R253, 00000001
        window_msg '              TIME UP!'
        winend 
        ret 
        nop 
        nop 
        nop 
        message 0000041A, '** Thread that checks if wave 6 should spawn in section 32.'
270:    sync 
        leti R150, 00000003
        leti R151, 000000DD
        if_switch_pressed R150
        jmpi_= R152, 00000000, 270
271:    sync 
        leti R151, 000000DE
        if_switch_pressed R150
        jmpi_= R152, 00000000, 271
272:    sync 
        leti R151, 000000DF
        if_switch_pressed R150
        jmpi_= R152, 00000000, 272
273:    sync 
        leti R151, 000000E0
        if_switch_pressed R150
        jmpi_= R152, 00000000, 273
274:    sync 
        leti R151, 000000E1
        if_switch_pressed R150
        jmpi_= R152, 00000000, 274
        setevt 0000007E
        ret 
        message 0000041A, '** Thread that checks if room 42 can be opened on either side'
280:    sync 
        thread_stg 281
        thread_stg 282
        ret 
        message 0000041A, '** Check's room 30's switch (202). If opened, unlock left door'
281:    sync 
        leti R160, 00000003
        leti R161, 000000CA
        if_switch_pressed R160
        jmpi_= R162, 00000000, 281
        setevt 0000012C
        ret 
        message 0000041A, ''** Check's room 12's switch (203). If opened, unlock right door''
282:    sync 
        leti R163, 00000003
        leti R164, 000000CB
        if_switch_pressed R163
        jmpi_= R165, 00000000, 282
        setevt 00000078
        ret 
        message 0000041A, '** Thread that checks if final door is opened (quest cleared).'
260:    sync 
        leti R240, 00000003
        leti R241, 00000027
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
        message 0000041A, '** Checks for threaded spawns, not used in this quest'
1011:   sync 
        ret 
        jmp 1011
        leti R60, 00000001
        leti R61, 00000029
        if_zone_clear R62, R60
        jmpi_= R62, 00000000, 1011
        setevt 0000019A
1012:   sync 
        leti R60, 00000001
        leti R61, 00000032
        if_zone_clear R62, R60
        jmpi_= R62, 00000000, 1012
        setevt 000001F4
1013:   sync 
        leti R60, 00000001
        leti R61, 00000046
        if_zone_clear R62, R60
        jmpi_= R62, 00000000, 1013
        setevt 000002BC
        ret 
        message 0000041A, '** Time up code below. Return to guild, disable warp.'
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
