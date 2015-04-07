<?php
require_once 'model.php';

$raters = get_all_raters();

require 'templates/raters.php';