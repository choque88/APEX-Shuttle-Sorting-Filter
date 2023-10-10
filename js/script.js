const shuttleSorting = function (apex, $) {
    "use strict";
    const featureDetails = {
        name: "CB.DEV.SHUTTLE.SORTING.FILTER",
        scriptVersion: "23.10.10"
    };

    return {
        initialize: function (pConfig) {
            apex.debug.info({
                "fct": featureDetails.name + " - initialize",
                "arguments": {
                    "pConfig": pConfig
                },
                "featureDetails": featureDetails
            });

            let config = $.extend({}, pConfig);
            config.defaultresetBtnTitle = "Reset filter";
            
            /* check the passed elements */
            checkIfShuttle();

            /***********************************************************************
            **
            ** function to check if the element is a shuttle
            **
            ***********************************************************************/
            function checkIfShuttle() {
                apex.debug.info("Checking the passed element(s)");
                const affectedElementsCleaned = config.affectedElements.replace(/#/g, '');
                let shuttleArray = affectedElementsCleaned.split(',');
                shuttleArray.forEach(function (entry) {
                    if ($(`#${entry}_LEFT`).length > 0 && $(`#${entry}_RIGHT`).length > 0) {
                        apex.debug.info(`${entry} is a shuttle.`);
                        if (config.mode == 0 || config.mode == 1) {
                            try {
                                sortShuttle(`${entry}_LEFT`);
                                sortShuttle(`${entry}_RIGHT`);
                            } catch (error) {
                                apex.debug.error(`Error while trying to sort the shuttle ${entry}`);
                                apex.debug.error(error);
                            }
                        }
                        if (config.mode == 0 && !document.getElementById(`${entry}_FILTER`) || config.mode == 2 && !document.getElementById(`${entry}_FILTER`)) {
                            try {
                                addShuttleFilter(entry);
                            } catch (error) {
                                apex.debug.error(`Error while trying to add the shuttle filter to ${entry}`);
                                apex.debug.error(error);
                            }
                        }
                    }
                });
            }
            /***********************************************************************
            **
            ** function to sort the shuttle(s)
            **
            ***********************************************************************/
            function sortShuttle(pShuttle) {
                let $shuttle = $(`#${pShuttle}`);
                let shuttleOptions = $shuttle.children("option");

                if (shuttleOptions.length > 0) {
                    apex.debug.info(`${pShuttle} contains options. Sorting.`)
                    shuttleOptions.detach();
                    shuttleOptions.sort(function (a, b) {
                        a = a.firstChild.nodeValue;
                        b = b.firstChild.nodeValue;
                        if (a == b) {
                            return 0;
                        }
                        if (config.sortOrder == 0) {
                            return (a > b) ? 1 : -1;
                        } else {
                            return (a < b) ? 1 : -1;
                        }
                    });
                    $shuttle.append(shuttleOptions);
                } else {
                    apex.debug.info(`${pShuttle} is empty. No sorting needed.`)
                }
            }
            /***********************************************************************
            **
            ** function to add the search bar to the shuttle(s)
            **
            ***********************************************************************/
            function addShuttleFilter(pShuttle) {
                let $shuttle = $(`#${pShuttle}`),
                    filterId = $shuttle.attr("id") + "_FILTER",
                    resetBtnId = $shuttle.attr("id") + "_RESET",
                    $select = $shuttle.find("select"),
                    shuttleValues = $select.children("option").map(function () {
                        return {
                            text: $(this).text(),
                            value: $(this).val(),
                            option: this
                        };
                    }),
                    $filter = $("<input/>", {
                        "type": "text",
                        "value": "",
                        "class": "text_field apex-item-text",
                        "size": "255",
                        "autocomplete": "off",
                        "id": filterId,
                        "placeholder": config.filterPlaceholder,
                        "css": {
                            "width": "100%"
                        }
                    })
                        .keyup(function () {
                            let filterval = new RegExp(".*" + $(this).val() + ".*", "i"),
                                selectedValues = $select.eq(1).children("option").map(function () {
                                    return $(this).val();
                                });
                            $select.eq(0).empty();
                            $.each(shuttleValues, function (idx, obj) {
                                if (obj.text.match(filterval) && $.inArray(obj.value, selectedValues) < 0) {
                                    $select.eq(0).append(obj.option);
                                }
                            });
                        }),
                    $resetBtn = $("<button/>", {
                        "type": "button",
                        "title": config.resetBtnTitle,
                        "aria-label": config.resetBtnTitle || config.defaultresetBtnTitle,
                        "class": "a-Button a-Button--noLabel a-Button--withIcon a-Button--small a-Button--shuttle",
                        "css": {
                            "padding": "4px",
                            "height": "100%"
                        }
                    }).append(
                        $("<span/>", {
                            "aria-hidden": "true",
                            "class": "a-Icon fa fa-times",
                        })
                    ).click(function () {
                        // clear filter text field
                        $filter.val("").keyup();
                    });
                $($shuttle).prepend(
                    $("<div/>", {
                        "class": "t-Form-itemWrapper"
                    })
                        .append($filter).append(
                            $("<span/>", {
                                "class": "t-Form-itemText t-Form-itemText--post"
                            }).append($resetBtn)
                        )
                ).on("apexafterrefresh", function () {
                    /* reinitialize filter */
                    $filter.val("");
                    shuttleValues = getShuttleValues($select);
                });

                $("#" + resetBtnId).click(function () {
                    $filter.val("");
                });
            }
        }
    }
};